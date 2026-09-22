import 'package:entity/entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storage_api/storage_api.dart';
import 'package:triary_app/l10n/app_localizations.dart';
import 'package:triary_app/widgets/dialogs.dart';

/// Итог завершённой тренировки: дата, выполнено упражнений, набор, список
/// упражнений с подходами.
class WorkoutStatisticsScreen extends StatefulWidget {
  final String trainingId;

  const WorkoutStatisticsScreen({super.key, required this.trainingId});

  @override
  State<WorkoutStatisticsScreen> createState() =>
      _WorkoutStatisticsScreenState();
}

class _WorkoutStatisticsScreenState extends State<WorkoutStatisticsScreen> {
  PowerTraining? _training;
  String? _setName;
  List<Exercise> _exercises = const [];
  Map<String, List<PowerTrainingApproach>> _approachesByExercise = const {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final trainingRepo = context.read<BasePowerTrainingRepository>();
    final approachRepo = context.read<BasePowerTrainingApproachRepository>();
    final setRepo = context.read<BaseExerciseSetRepository>();
    final exerciseRepo = context.read<BaseExerciseRepository>();

    final training = await trainingRepo.findById(widget.trainingId);
    final approaches =
        (await approachRepo.findByTraining(widget.trainingId)).toList();

    String? setName;
    List<Exercise> exercises = const [];
    if (training != null && training.exerciseSetId != null) {
      final sets = await setRepo.findAll();
      ExerciseSet? foundSet;
      for (final s in sets) {
        if (s.id == training.exerciseSetId) {
          foundSet = s;
          break;
        }
      }
      setName = foundSet?.name;

      final items = await setRepo.findAllItems(training.exerciseSetId!);
      final all = await exerciseRepo.findAll();
      final byId = {for (final e in all) e.id: e};
      exercises =
          items.map((i) => byId[i.exerciseId]).whereType<Exercise>().toList();
    }

    final grouped = <String, List<PowerTrainingApproach>>{};
    for (final a in approaches) {
      grouped.putIfAbsent(a.exerciseId, () => <PowerTrainingApproach>[]).add(a);
    }
    for (final list in grouped.values) {
      list.sort((a, b) => a.position.compareTo(b.position));
    }

    if (mounted) {
      setState(() {
        _training = training;
        _setName = setName;
        _exercises = exercises;
        _approachesByExercise = grouped;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final training = _training;
    if (training == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.statistics)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final completed = _exercises
        .where((e) => (_approachesByExercise[e.id] ?? const []).isNotEmpty)
        .length;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.statistics)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            training.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          if (training.date != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '${l10n.date}: '
                '${MaterialLocalizations.of(context).formatMediumDate(training.date!)}',
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text('${l10n.completedExercises}: $completed'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text('${l10n.trainingSet}: ${_setName ?? l10n.noSet}'),
          ),
          const SizedBox(height: 16),
          for (final exercise in _exercises)
            _buildExercise(context, exercise),
        ],
      ),
    );
  }

  Widget _buildExercise(BuildContext context, Exercise exercise) {
    final approaches =
        _approachesByExercise[exercise.id] ?? const <PowerTrainingApproach>[];
    return Card(
      child: ListTile(
        title: Text(exercise.name),
        subtitle: approaches.isEmpty
            ? null
            : Text(
                approaches
                    .map((a) => '${a.reps} × ${formatWeight(a.weight)}')
                    .join(', '),
              ),
        trailing: Text('${approaches.length}'),
      ),
    );
  }
}

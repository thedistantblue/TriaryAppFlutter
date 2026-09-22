import 'package:entity/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:storage_api/storage_api.dart';
import 'package:triary_app/bloc/power_training_bloc.dart';
import 'package:triary_app/l10n/app_localizations.dart';
import 'package:triary_app/tabs/power/exercise_catalog_screen.dart';
import 'package:triary_app/tabs/power/exercise_set_screen.dart';
import 'package:triary_app/tabs/power/workout_execution_screen.dart';
import 'package:triary_app/tabs/power/workout_statistics_screen.dart';
import 'package:triary_app/widgets/dialogs.dart';

class PowerTrainingList extends StatefulWidget {
  const PowerTrainingList({super.key});

  @override
  State<PowerTrainingList> createState() => _PowerTrainingListState();
}

class _PowerTrainingListState extends State<PowerTrainingList> {
  bool _newestFirst = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PowerTrainingBloc, PowerTrainingState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        return Scaffold(
          body: Column(
            children: [
              _buildHeader(context, l10n),
              Expanded(child: _buildList(context, state, l10n)),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showCreateDialog(context),
            label: Text(l10n.addTraining),
            icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ExerciseCatalogScreen(),
              ),
            ),
            child: Text(l10n.exercises),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ExerciseSetScreen(),
              ),
            ),
            child: Text(l10n.exercisesSets),
          ),
          const Spacer(),
          PopupMenuButton<bool>(
            icon: const Icon(Icons.sort),
            onSelected: (value) => setState(() => _newestFirst = value),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: true,
                child: Text(l10n.newestFirst),
              ),
              PopupMenuItem(
                value: false,
                child: Text(l10n.oldestFirst),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    PowerTrainingState state,
    AppLocalizations l10n,
  ) {
    if (state.status == PowerTrainingStatus.initial) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.powerTrainings.isEmpty) {
      return Center(child: Text(l10n.addTraining));
    }

    final sorted = [...state.powerTrainings];
    sorted.sort((a, b) {
      final aDate = a.date;
      final bDate = b.date;
      if (aDate == null && bDate == null) return 0;
      if (aDate == null) return -1;
      if (bDate == null) return 1;
      return _newestFirst ? bDate.compareTo(aDate) : aDate.compareTo(bDate);
    });

    final children = <Widget>[];
    String? currentHeader;
    for (final training in sorted) {
      final header = training.date == null
          ? l10n.inProgress
          : MaterialLocalizations.of(context).formatMonthYear(training.date!);
      if (header != currentHeader) {
        currentHeader = header;
        children.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              header,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        );
      }
      children.add(_buildCard(context, training, l10n));
    }

    return ListView(children: children);
  }

  Widget _buildCard(
    BuildContext context,
    PowerTraining training,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Dismissible(
        key: Key(training.id),
        direction: DismissDirection.startToEnd,
        confirmDismiss: (_) => _deleteTrainingDialog(context, training),
        onDismissed: (_) {
          context
              .read<PowerTrainingBloc>()
              .add(PowerTrainingDeleted(training));
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 16),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: Card(
          child: ListTile(
            title: Text(training.name),
            subtitle: Text(
              training.description.isEmpty
                  ? l10n.inProgress
                  : training.description,
            ),
            trailing: training.date == null
                ? null
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${training.date!.day}'),
                      IconButton(
                        icon: const Icon(Icons.bar_chart),
                        tooltip: l10n.statistics,
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkoutStatisticsScreen(
                              trainingId: training.id,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            onTap: () => _openExecution(context, training),
          ),
        ),
      ),
    );
  }

  Future<void> _openExecution(
    BuildContext context,
    PowerTraining training,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WorkoutExecutionScreen(trainingId: training.id),
      ),
    );
    if (mounted) {
      context.read<PowerTrainingBloc>().add(PowerTrainingChanged());
    }
  }

  Future<bool> _deleteTrainingDialog(
    BuildContext context,
    PowerTraining training,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    return showConfirmDialog(
      context,
      title: l10n.trainingDeletion,
      message: '${l10n.trainingDeletionText} ${training.name}?',
    );
  }

  void _showCreateDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => CreateTrainingDialog(
        bloc: context.read<PowerTrainingBloc>(),
      ),
    );
  }
}

class CreateTrainingDialog extends StatefulWidget {
  final PowerTrainingBloc bloc;

  const CreateTrainingDialog({super.key, required this.bloc});

  @override
  State<CreateTrainingDialog> createState() => _CreateTrainingDialogState();
}

class _CreateTrainingDialogState extends State<CreateTrainingDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<ExerciseSet> _sets = const [];
  String? _selectedSetId;

  @override
  void initState() {
    super.initState();
    _loadSets();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadSets() async {
    final sets = await context.read<BaseExerciseSetRepository>().findAll();
    if (mounted) setState(() => _sets = sets.toList());
  }

  Future<void> _createNewSet() async {
    final l10n = AppLocalizations.of(context)!;
    final name = await showNameDialog(context, title: l10n.addSet);
    if (name == null) return;
    final set = await context
        .read<BaseExerciseSetRepository>()
        .create(ExerciseSet(name: name));
    if (mounted) {
      setState(() {
        _sets = [..._sets, set];
        _selectedSetId = set.id;
      });
    }
  }

  void _submit() {
    widget.bloc.add(
      PowerTrainingCreated(
        PowerTraining(
          name: _nameController.text,
          description: _descriptionController.text,
          exerciseSetId: _selectedSetId,
        ),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.addTraining),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: l10n.name,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: l10n.description,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String?>(
              value: _selectedSetId,
              decoration: InputDecoration(
                labelText: l10n.trainingSet,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text(l10n.noSet),
                ),
                for (final s in _sets)
                  DropdownMenuItem<String?>(
                    value: s.id,
                    child: Text(s.name),
                  ),
              ],
              onChanged: (value) => setState(() => _selectedSetId = value),
            ),
            TextButton(
              onPressed: _createNewSet,
              child: Text(l10n.addSet),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(l10n.create),
        ),
      ],
    );
  }
}

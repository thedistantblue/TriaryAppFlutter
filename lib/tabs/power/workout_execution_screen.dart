import 'package:entity/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:storage_api/storage_api.dart';
import 'package:triary_app/bloc/power_training_execution_bloc.dart';
import 'package:triary_app/l10n/app_localizations.dart';
import 'package:triary_app/tabs/power/exercise_history_screen.dart';
import 'package:triary_app/tabs/power/workout_statistics_screen.dart';
import 'package:triary_app/widgets/dialogs.dart';

const int _restSeconds = 90;

class WorkoutExecutionScreen extends StatelessWidget {
  final String trainingId;

  const WorkoutExecutionScreen({super.key, required this.trainingId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PowerTrainingExecutionBloc(
        context.read<BasePowerTrainingRepository>(),
        context.read<BaseExerciseSetRepository>(),
        context.read<BaseExerciseRepository>(),
        context.read<BasePowerTrainingApproachRepository>(),
      )..add(PowerTrainingExecutionStarted(trainingId)),
      child: const _ExecutionView(),
    );
  }
}

class _ExecutionView extends StatefulWidget {
  const _ExecutionView();

  @override
  State<_ExecutionView> createState() => _ExecutionViewState();
}

class _ExecutionViewState extends State<_ExecutionView> {
  final _repsController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose() {
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<PowerTrainingExecutionBloc,
        PowerTrainingExecutionState>(
      listener: (context, state) {
        if (state.finished) {
          final trainingId = state.training?.id;
          if (trainingId != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => WorkoutStatisticsScreen(trainingId: trainingId),
              ),
            );
          }
        } else if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage(state.error!, l10n))),
          );
        }
      },
      builder: (context, state) {
        final current = state.currentExercise;
        return Scaffold(
          appBar: AppBar(
            title: Text(state.training?.name ?? l10n.powerTraining),
            actions: [
              IconButton(
                icon: const Icon(Icons.history),
                tooltip: l10n.previousRecords,
                onPressed: () => _openHistory(context),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                if (current != null)
                  Text(
                    current.name,
                    style: const TextStyle(fontSize: 22),
                  )
                else
                  Text(l10n.addExercise),
                const SizedBox(height: 8),
                Expanded(
                  child: _buildApproaches(context, state, current, l10n),
                ),
                _buildAddApproach(context, current, l10n),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: state.currentExerciseIndex <
                                state.exercises.length - 1
                            ? () => context
                                .read<PowerTrainingExecutionBloc>()
                                .add(PowerTrainingNextExercise())
                            : null,
                        child: Text(l10n.nextExercise),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton(
                        onPressed: () => _finish(context),
                        child: Text(l10n.finishTraining),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildApproaches(
    BuildContext context,
    PowerTrainingExecutionState state,
    Exercise? current,
    AppLocalizations l10n,
  ) {
    if (current == null) return const SizedBox.shrink();
    final approaches =
        state.approachesByExercise[current.id] ?? const <PowerTrainingApproach>[];
    if (approaches.isEmpty) {
      return Center(child: Text(l10n.addApproach));
    }
    return ListView.builder(
      itemCount: approaches.length,
      itemBuilder: (context, index) {
        final approach = approaches[index];
        return _ApproachTile(approach: approach, l10n: l10n);
      },
    );
  }

  Widget _buildAddApproach(
    BuildContext context,
    Exercise? current,
    AppLocalizations l10n,
  ) {
    if (current == null) return const SizedBox.shrink();
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _repsController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l10n.reps,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: _weightController,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.weight,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle),
          onPressed: () => _addApproach(context, current),
        ),
      ],
    );
  }

  void _addApproach(BuildContext context, Exercise current) {
    final reps = int.tryParse(_repsController.text.trim()) ?? 0;
    final weight =
        double.tryParse(_weightController.text.trim().replaceAll(',', '.')) ??
            0;
    if (reps <= 0) return;
    context.read<PowerTrainingExecutionBloc>().add(
          PowerTrainingApproachAdded(
            exerciseId: current.id,
            reps: reps,
            weight: weight,
          ),
        );
    _repsController.clear();
    _weightController.clear();
  }

  Future<void> _finish(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.finishTraining,
      message: l10n.finishTrainingText,
    );
    if (confirmed) {
      context
          .read<PowerTrainingExecutionBloc>()
          .add(PowerTrainingExecutionFinished());
    }
  }

  void _openHistory(BuildContext context) {
    final bloc = context.read<PowerTrainingExecutionBloc>();
    final current = bloc.state.currentExercise;
    final trainingId = bloc.state.training?.id;
    if (current == null || trainingId == null) return;
    bloc.add(PowerTrainingPreviousRequested(current.id));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ExerciseHistoryScreen(
          bloc: bloc,
          exerciseId: current.id,
          trainingId: trainingId,
        ),
      ),
    );
  }
}

class _ApproachTile extends StatelessWidget {
  final PowerTrainingApproach approach;
  final AppLocalizations l10n;

  const _ApproachTile({required this.approach, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PowerTrainingExecutionBloc>();
    final isApplied = approach.source == ApproachSource.applied;
    final color = isApplied ? const Color(0xFF48CAA0) : Colors.grey;
    return Card(
      child: ExpansionTile(
        leading: Icon(Icons.circle, size: 12, color: color),
        title: Text('${approach.reps} × ${formatWeight(approach.weight)}'),
        subtitle: Text(
          isApplied ? l10n.appliedApproach : l10n.manualApproach,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () =>
              bloc.add(PowerTrainingApproachRemoved(approach.id)),
        ),
        children: const [_RestTimerControls()],
      ),
    );
  }
}

class _RestTimerControls extends StatelessWidget {
  const _RestTimerControls();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<PowerTrainingExecutionBloc,
        PowerTrainingExecutionState>(
      builder: (context, state) {
        final bloc = context.read<PowerTrainingExecutionBloc>();
        if (state.restRemaining == null) {
          return ListTile(
            leading: const Icon(Icons.timer_outlined),
            title: Text(l10n.rest),
            trailing: TextButton(
              onPressed: () => bloc.add(RestTimerStarted(_restSeconds)),
              child: Text(l10n.startRest),
            ),
          );
        }
        return ListTile(
          leading: const Icon(Icons.timer),
          title: Text(
            '${l10n.restTimer}: ${state.restRemaining} ${l10n.seconds}',
          ),
          trailing: TextButton(
            onPressed: () => bloc.add(RestTimerCancelled()),
            child: Text(l10n.cancel),
          ),
        );
      },
    );
  }
}
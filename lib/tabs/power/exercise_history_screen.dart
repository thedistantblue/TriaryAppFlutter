import 'package:entity/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triary_app/bloc/power_training_execution_bloc.dart';
import 'package:triary_app/l10n/app_localizations.dart';
import 'package:triary_app/widgets/dialogs.dart';

/// Экран «Предыдущие записи»: прошлые подходы по упражнению с фильтром
/// «все тренировки / только эта тренировка» и применением выбранных значений.
class ExerciseHistoryScreen extends StatefulWidget {
  final PowerTrainingExecutionBloc bloc;
  final String exerciseId;
  final String trainingId;

  const ExerciseHistoryScreen({
    super.key,
    required this.bloc,
    required this.exerciseId,
    required this.trainingId,
  });

  @override
  State<ExerciseHistoryScreen> createState() => _ExerciseHistoryScreenState();
}

class _ExerciseHistoryScreenState extends State<ExerciseHistoryScreen> {
  bool _onlyCurrent = false;
  final Set<String> _selected = {};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<PowerTrainingExecutionBloc,
        PowerTrainingExecutionState>(
      bloc: widget.bloc,
      builder: (context, state) {
        final records = _onlyCurrent
            ? state.previousRecords
                .where((r) => r.powerTrainingId == widget.trainingId)
                .toList()
            : state.previousRecords;
        return Scaffold(
          appBar: AppBar(title: Text(l10n.previousRecords)),
          body: Column(
            children: [
              SwitchListTile(
                value: _onlyCurrent,
                onChanged: (value) => setState(() => _onlyCurrent = value),
                title: Text(l10n.currentTrainingOnly),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              const Divider(height: 1),
              Expanded(
                child: records.isEmpty
                    ? Center(child: Text(l10n.noPreviousRecords))
                    : ListView.builder(
                        itemCount: records.length,
                        itemBuilder: (context, index) {
                          final record = records[index];
                          final isApplied =
                              record.source == ApproachSource.applied;
                          return CheckboxListTile(
                            value: _selected.contains(record.id),
                            onChanged: (value) => setState(() {
                              if (value == true) {
                                _selected.add(record.id);
                              } else {
                                _selected.remove(record.id);
                              }
                            }),
                            title: Text(
                              '${record.reps} × ${formatWeight(record.weight)}',
                            ),
                            secondary: Icon(
                              Icons.circle,
                              size: 12,
                              color: isApplied
                                  ? const Color(0xFF48CAA0)
                                  : Colors.grey,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton(
                onPressed: _selected.isEmpty ? null : _apply,
                child: Text('${l10n.apply} (${_selected.length})'),
              ),
            ),
          ),
        );
      },
    );
  }

  void _apply() {
    final records = widget.bloc.state.previousRecords
        .where((r) => _selected.contains(r.id))
        .toList();
    widget.bloc.add(PowerTrainingPreviousApplied(widget.exerciseId, records));
    Navigator.of(context).pop();
  }
}

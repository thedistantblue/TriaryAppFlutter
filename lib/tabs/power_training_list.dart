import 'package:entity/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triary_app/bloc/power_training_bloc.dart';
import 'package:triary_app/l10n/app_localizations.dart';
import 'package:triary_app/tabs/power/pt_details.dart';
import 'package:triary_app/widgets/name_description_widget.dart';
import 'package:triary_app/widgets/power_training_card.dart';

class PowerTrainingList extends StatefulWidget {
  const PowerTrainingList({super.key});

  @override
  State<PowerTrainingList> createState() => _PowerTrainingListState();
}

class _PowerTrainingListState extends State<PowerTrainingList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PowerTrainingBloc, PowerTrainingState>(
      builder: (context, state) {
        return Scaffold(
          body: state.powerTrainings.isEmpty
              ? const _EmptyTrainingList()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: state.powerTrainings.length,
                      itemBuilder: (context, index) {
                        final training = state.powerTrainings[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Dismissible(
                            key: Key(training.id),
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.error,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.centerLeft,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(
                                Icons.delete,
                                color: Theme.of(context).colorScheme.onError,
                              ),
                            ),
                            confirmDismiss: (direction) {
                              return deleteTrainingDialog(context, training);
                            },
                            onDismissed: (direction) {
                              context
                                  .read<PowerTrainingBloc>()
                                  .add(PowerTrainingDeleted(training));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .trainingDeleted(training.name),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: PowerTrainingCard(
                              name: training.name,
                              description: training.description,
                              onTap: () => Navigator.of(context).pushNamed(
                                "/pt_details",
                                arguments: training,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              createTrainingDialog(context);
            },
            label: Text(AppLocalizations.of(context)!.addTraining),
            icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Future<bool> deleteTrainingDialog(
      BuildContext context, PowerTraining training) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.trainingDeletion),
          content: Text("${AppLocalizations.of(context)!.trainingDeletionText}"
              " ${training.name}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(AppLocalizations.of(context)!.delete),
            ),
          ],
        );
      },
    ) ??
        false;
  }

  void createTrainingDialog(BuildContext context) {
    final bloc = context.read<PowerTrainingBloc>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.addTraining),
        content: NameDescriptionWidget(
          createFunction: (name, description) {
            bloc.add(
              PowerTrainingCreated(
                PowerTraining(name: name, description: description),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _EmptyTrainingList extends StatelessWidget {
  const _EmptyTrainingList();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.fitness_center,
            size: 64,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noTrainings,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.noTrainingsHint,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}

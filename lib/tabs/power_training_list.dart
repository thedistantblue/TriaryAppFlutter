import 'package:flutter/material.dart';
import 'package:triary_app/data/data_base/base_power_training_repository.dart';
import 'package:triary_app/entity/training/power_training.dart';
import 'package:triary_app/widgets/name_description_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PowerTrainingList extends StatefulWidget {
  final BasePowerTrainingRepository _repository;

  const PowerTrainingList(this._repository, {super.key});

  @override
  State<PowerTrainingList> createState() => _PowerTrainingListState();
}

class _PowerTrainingListState extends State<PowerTrainingList> {
  List<PowerTraining> _trainings = [];

  void getAllTrainings() {
    widget._repository.findAll().then((result) {
      setState(() {
        _trainings = result.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllTrainings();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          child: ListView.builder(
            itemCount: _trainings.length,
            itemBuilder: (context, index) {
              final training = _trainings[index];
              return GestureDetector(
                child: SizedBox(
                  height: 100,
                  child: Dismissible(
                    key: Key(training.id),
                    onDismissed: (direction) {
                      setState(() {
                        _trainings.removeAt(index);
                        deleteTraining(training);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text('${training.name} deleted'),
                          ),
                        ),
                      );
                    },
                    background: const Card(
                      color: Colors.red,
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            size: 40,
                            color: Color(0xffffffff),
                          ),
                        ],
                      ),
                    ),
                    confirmDismiss: (a) {
                      return deleteTrainingDialog(context, training);
                    },
                    direction: DismissDirection.startToEnd,
                    child: SizedBox.expand(
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(training.name),
                            Text(training.description),
                          ],
                        ),
                
                      ),
                    ),
                  ),
                ),
                onTap: () => Navigator.of(context).pushNamed("/pt_details"),
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
  }

  Future<bool> deleteTrainingDialog(
      BuildContext context, PowerTraining training) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.trainingDeletion),
          content: Text("${AppLocalizations.of(context)!.trainingDeletionText}"
              " ${training.name}?"),
          actions: [
            MaterialButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(AppLocalizations.of(context)!.delete)),
            MaterialButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
          ],
        );
      },
    );
  }

  void deleteTraining(PowerTraining training) {
    widget._repository.deleteById(training.id);
    getAllTrainings();
  }

  void createTrainingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 220,
            child: NameDescriptionWidget(
              createFunction: ((String, String) record) {
                createTraining(record);
              },
            ),
          ),
        ),
      ),
    );
  }

  void createTraining((String, String) record) {
    widget._repository.create(PowerTraining(record.$1, record.$2));
    getAllTrainings();
  }
}

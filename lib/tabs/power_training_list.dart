import 'package:flutter/material.dart';
import 'package:triary_app/data/data_base/base_power_training_repository.dart';
import 'package:triary_app/entity/training/power_training.dart';
import 'package:triary_app/widgets/name_description_widget.dart';

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
              return SizedBox(
                height: 100,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_trainings[index].name),
                      Text(_trainings[index].description),
                    ],
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
        label: const Text("Add training"),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void createTrainingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 250,
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

import 'package:flutter/material.dart';
import 'package:triary_app/data/data_base/base_power_training_repository.dart';
import 'package:triary_app/entity/training/power_training.dart';

class PowerTrainingList extends StatelessWidget {
  final BasePowerTrainingRepository _repository;

  const PowerTrainingList(this._repository, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Iterable<PowerTraining>>(
        future: _repository.findAll(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return Text(snapshot.data!.first.name);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            _repository.create(PowerTraining("name", "description"));
          }
      ),
    );
  }

}
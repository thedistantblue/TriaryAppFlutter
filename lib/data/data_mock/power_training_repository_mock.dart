import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:triary_app/data/data_base/base_power_training_repository.dart';
import 'package:triary_app/data/data_base/uuid_generator.dart';
import 'package:triary_app/entity/training/power_training.dart';

class PowerTrainingRepositoryMock implements BasePowerTrainingRepository{
  final BuildContext _buildContext;
  final Map<String, PowerTraining> _idToTrainingMap = {};

  PowerTrainingRepositoryMock(this._buildContext);

  @override
  PowerTraining create(PowerTraining training) {
    training.id = Provider.of<UuidGenerator>(_buildContext).generateUuid();
    _idToTrainingMap[training.id] = training;
    return training;
  }

  @override
  Future<PowerTraining?> findById(String id) {
    return Future.delayed(
        const Duration(milliseconds: 2),
            () => _idToTrainingMap[id]);
  }

  @override
  Future<Iterable<PowerTraining>> findAllById(Iterable<String> ids) {
    return Future.delayed(
      const Duration(milliseconds: 2),
            () {
              final List<PowerTraining> trainings = [];
              for (var e in ids) {
                var training = _idToTrainingMap[e];
                if (training != null) {
                  trainings.add(training);
                }
              }
              return trainings;
            }
    );
  }

  @override
  Future<PowerTraining?> deleteById(String id) {
    return Future.delayed(
        const Duration(milliseconds: 2),
            () => _idToTrainingMap.remove(id));
  }
}

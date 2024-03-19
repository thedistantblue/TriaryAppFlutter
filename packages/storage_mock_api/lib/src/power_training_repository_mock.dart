import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';

class PowerTrainingRepositoryMock implements BasePowerTrainingRepository{
  final UuidGenerator _uuidGenerator;
  final Map<String, PowerTraining> _idToTrainingMap = {};

  PowerTrainingRepositoryMock(this._uuidGenerator);

  @override
  PowerTraining create(PowerTraining training) {
    training.id = _uuidGenerator.generateUuid();
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
  Stream<Iterable<PowerTraining>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
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

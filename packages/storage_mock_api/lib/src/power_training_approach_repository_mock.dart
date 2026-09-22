import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';
import 'package:storage_mock_api/src/in_memory_store.dart';

class PowerTrainingApproachRepositoryMock
    implements BasePowerTrainingApproachRepository {
  final UuidGenerator _uuidGenerator;
  final InMemoryStore _store;

  PowerTrainingApproachRepositoryMock(this._uuidGenerator, this._store);

  @override
  Future<PowerTrainingApproach> create(PowerTrainingApproach approach) async {
    await Future.delayed(const Duration(milliseconds: 2));
    final persisted = approach.copyWith(id: _uuidGenerator.generateUuid());
    _store.approaches[persisted.id] = persisted;
    return persisted;
  }

  @override
  Future<Iterable<PowerTrainingApproach>> findByTraining(
      String powerTrainingId) async {
    await Future.delayed(const Duration(milliseconds: 2));
    final approaches = _store.approaches.values
        .where((a) => a.powerTrainingId == powerTrainingId)
        .toList()
      ..sort((a, b) => a.position.compareTo(b.position));
    return approaches;
  }

  @override
  Future<Iterable<PowerTrainingApproach>> findByExercise(
      String exerciseId) async {
    await Future.delayed(const Duration(milliseconds: 2));
    return _store.approaches.values
        .where((a) => a.exerciseId == exerciseId)
        .toList();
  }

  @override
  Future<void> deleteById(String id) async {
    await Future.delayed(const Duration(milliseconds: 2));
    _store.approaches.remove(id);
  }
}

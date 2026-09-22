import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';
import 'package:storage_mock_api/src/in_memory_store.dart';

class PowerTrainingRepositoryMock implements BasePowerTrainingRepository {
  final UuidGenerator _uuidGenerator;
  final InMemoryStore _store;

  PowerTrainingRepositoryMock(this._uuidGenerator, this._store);

  @override
  Future<PowerTraining> create(PowerTraining training) async {
    await Future.delayed(const Duration(milliseconds: 2));
    final persisted = training.copyWith(id: _uuidGenerator.generateUuid());
    _store.trainings[persisted.id] = persisted;
    return persisted;
  }

  @override
  Future<PowerTraining?> findById(String id) async {
    await Future.delayed(const Duration(milliseconds: 2));
    return _store.trainings[id];
  }

  @override
  Stream<Iterable<PowerTraining>> findAll() async* {
    // Reactive watch is out of scope for the mock; emit the current state.
    yield _store.trainings.values.toList();
  }

  @override
  Future<Iterable<PowerTraining>> findAllById(Iterable<String> ids) async {
    await Future.delayed(const Duration(milliseconds: 2));
    return ids.map((id) => _store.trainings[id]).whereType<PowerTraining>().toList();
  }

  @override
  Future<Iterable<PowerTraining>> findAllSortedByDate() async {
    await Future.delayed(const Duration(milliseconds: 2));
    final trainings = _store.trainings.values.toList();
    trainings.sort((a, b) {
      final dateA = a.date;
      final dateB = b.date;
      if (dateA == null && dateB == null) return 0;
      if (dateA == null) return 1;
      if (dateB == null) return -1;
      return dateB.compareTo(dateA);
    });
    return trainings;
  }

  @override
  Future<void> setDate(String id, DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 2));
    final training = _store.trainings[id];
    if (training != null) {
      _store.trainings[id] = training.copyWith(date: date);
    }
  }

  @override
  Future<void> deleteById(String id) async {
    await Future.delayed(const Duration(milliseconds: 2));
    _store.approaches.removeWhere((_, a) => a.powerTrainingId == id);
    _store.trainings.remove(id);
  }
}

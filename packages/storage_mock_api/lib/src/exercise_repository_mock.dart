import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';
import 'package:storage_mock_api/src/in_memory_store.dart';

class ExerciseRepositoryMock implements BaseExerciseRepository {
  final UuidGenerator _uuidGenerator;
  final InMemoryStore _store;

  ExerciseRepositoryMock(this._uuidGenerator, this._store);

  @override
  Future<Exercise> create(Exercise exercise) async {
    await Future.delayed(const Duration(milliseconds: 2));
    final name = exercise.name.trim();
    if (name.isEmpty) {
      throw const EmptyNameException();
    }
    final exists = _store.exercises.values.any((e) => e.name == name);
    if (exists) {
      throw NameAlreadyExistsException(name);
    }
    final persisted = exercise.copyWith(
      id: _uuidGenerator.generateUuid(),
      name: name,
    );
    _store.exercises[persisted.id] = persisted;
    return persisted;
  }

  @override
  Future<Iterable<Exercise>> findAll() async {
    await Future.delayed(const Duration(milliseconds: 2));
    return _store.exercises.values.toList();
  }

  @override
  Future<void> deleteById(String id) async {
    await Future.delayed(const Duration(milliseconds: 2));
    final hasApproach =
        _store.approaches.values.any((a) => a.exerciseId == id);
    if (hasApproach) {
      throw const EntityInUseException();
    }
    _store.setItems.removeWhere((_, item) => item.exerciseId == id);
    _store.exercises.remove(id);
  }
}

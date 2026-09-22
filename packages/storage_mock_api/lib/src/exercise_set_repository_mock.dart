import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';
import 'package:storage_mock_api/src/in_memory_store.dart';

class ExerciseSetRepositoryMock implements BaseExerciseSetRepository {
  final UuidGenerator _uuidGenerator;
  final InMemoryStore _store;

  ExerciseSetRepositoryMock(this._uuidGenerator, this._store);

  @override
  Future<ExerciseSet> create(ExerciseSet set) async {
    await Future.delayed(const Duration(milliseconds: 2));
    final name = set.name.trim();
    if (name.isEmpty) {
      throw const EmptyNameException();
    }
    final exists = _store.sets.values.any((s) => s.name == name);
    if (exists) {
      throw NameAlreadyExistsException(name);
    }
    final persisted = set.copyWith(
      id: _uuidGenerator.generateUuid(),
      name: name,
      isCurrent: _store.sets.isEmpty,
    );
    _store.sets[persisted.id] = persisted;
    return persisted;
  }

  @override
  Future<Iterable<ExerciseSet>> findAll() async {
    await Future.delayed(const Duration(milliseconds: 2));
    return _store.sets.values.toList();
  }

  @override
  Future<Iterable<ExerciseSetItem>> findAllItems(String setId) async {
    await Future.delayed(const Duration(milliseconds: 2));
    final items = _store.setItems.values
        .where((i) => i.exerciseSetId == setId && !i.isDeleted)
        .toList()
      ..sort((a, b) => a.position.compareTo(b.position));
    return items;
  }

  @override
  Future<void> addItem(String setId, String exerciseId) async {
    await Future.delayed(const Duration(milliseconds: 2));
    var nextPosition = 0;
    for (final item in _store.setItems.values) {
      if (item.exerciseSetId == setId && item.position >= nextPosition) {
        nextPosition = item.position + 1;
      }
    }
    final item = ExerciseSetItem(
      id: _uuidGenerator.generateUuid(),
      exerciseSetId: setId,
      exerciseId: exerciseId,
      position: nextPosition,
    );
    _store.setItems[item.id] = item;
  }

  @override
  Future<void> reorder(String setId, Iterable<String> exerciseIds) async {
    await Future.delayed(const Duration(milliseconds: 2));
    var position = 0;
    for (final exerciseId in exerciseIds) {
      for (final item in _store.setItems.values) {
        if (item.exerciseSetId == setId && item.exerciseId == exerciseId) {
          _store.setItems[item.id] = item.copyWith(position: position);
        }
      }
      position++;
    }
  }

  @override
  Future<void> softDeleteItem(String setId, String exerciseId) async {
    await Future.delayed(const Duration(milliseconds: 2));
    for (final item in _store.setItems.values) {
      if (item.exerciseSetId == setId && item.exerciseId == exerciseId) {
        _store.setItems[item.id] = item.copyWith(isDeleted: true);
      }
    }
  }

  @override
  Future<void> setCurrent(String id) async {
    await Future.delayed(const Duration(milliseconds: 2));
    for (final set in _store.sets.values) {
      if (set.isCurrent) {
        _store.sets[set.id] = set.copyWith(isCurrent: false);
      }
    }
    final target = _store.sets[id];
    if (target != null) {
      _store.sets[id] = target.copyWith(isCurrent: true);
    }
  }

  @override
  Future<void> deleteById(String id) async {
    await Future.delayed(const Duration(milliseconds: 2));
    final usedBy = _store.trainings.values.any((t) => t.exerciseSetId == id);
    if (usedBy) {
      throw const EntityInUseException();
    }
    _store.setItems.removeWhere((_, item) => item.exerciseSetId == id);
    _store.sets.remove(id);
  }
}

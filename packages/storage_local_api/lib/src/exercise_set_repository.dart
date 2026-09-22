import 'package:drift/drift.dart';
import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';
import 'package:storage_local_api/local_storage_api.dart';

class ExerciseSetRepository extends BaseExerciseSetRepository {
  final UuidGenerator _uuidGenerator;
  final AppDatabase _database;

  ExerciseSetRepository(this._uuidGenerator, this._database);

  @override
  Future<ExerciseSet> create(ExerciseSet set) async {
    final name = set.name.trim();
    if (name.isEmpty) {
      throw const EmptyNameException();
    }
    final existing = await (_database.select(_database.exerciseSetTable)
          ..where((t) => t.name.equals(name)))
        .getSingleOrNull();
    if (existing != null) {
      throw NameAlreadyExistsException(name);
    }
    final hasAny = await (_database.select(_database.exerciseSetTable)
          ..limit(1))
        .getSingleOrNull();
    final persisted = set.copyWith(
      id: _uuidGenerator.generateUuid(),
      name: name,
      isCurrent: hasAny == null,
    );
    await _database.into(_database.exerciseSetTable).insert(
          ExerciseSetTableCompanion.insert(
            id: persisted.id,
            name: persisted.name,
            description: Value(persisted.description),
            isCurrent: persisted.isCurrent,
          ),
        );
    return persisted;
  }

  @override
  Future<Iterable<ExerciseSet>> findAll() async {
    final rows = await _database.select(_database.exerciseSetTable).get();
    return rows
        .map((e) => ExerciseSet(
              id: e.id,
              name: e.name,
              description: e.description,
              isCurrent: e.isCurrent,
            ))
        .toList();
  }

  @override
  Future<Iterable<ExerciseSetItem>> findAllItems(String setId) async {
    final rows = await (_database.select(_database.exerciseSetItemTable)
          ..where((t) => t.exerciseSetId.equals(setId) & t.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.position)]))
        .get();
    return rows
        .map((e) => ExerciseSetItem(
              id: e.id,
              exerciseSetId: e.exerciseSetId,
              exerciseId: e.exerciseId,
              position: e.position,
              isDeleted: e.isDeleted,
            ))
        .toList();
  }

  @override
  Future<void> addItem(String setId, String exerciseId) async {
    final last = await (_database.select(_database.exerciseSetItemTable)
          ..where((t) => t.exerciseSetId.equals(setId))
          ..orderBy([(t) => OrderingTerm.desc(t.position)])
          ..limit(1))
        .getSingleOrNull();
    final nextPosition = (last?.position ?? -1) + 1;
    await _database.into(_database.exerciseSetItemTable).insert(
          ExerciseSetItemTableCompanion.insert(
            id: _uuidGenerator.generateUuid(),
            exerciseSetId: setId,
            exerciseId: exerciseId,
            position: nextPosition,
            isDeleted: false,
          ),
        );
  }

  @override
  Future<void> reorder(String setId, Iterable<String> exerciseIds) async {
    var position = 0;
    for (final exerciseId in exerciseIds) {
      await (_database.update(_database.exerciseSetItemTable)
            ..where((t) =>
                t.exerciseSetId.equals(setId) & t.exerciseId.equals(exerciseId)))
          .write(ExerciseSetItemTableCompanion(position: Value(position)));
      position++;
    }
  }

  @override
  Future<void> softDeleteItem(String setId, String exerciseId) async {
    await (_database.update(_database.exerciseSetItemTable)
          ..where((t) =>
              t.exerciseSetId.equals(setId) & t.exerciseId.equals(exerciseId)))
        .write(const ExerciseSetItemTableCompanion(isDeleted: Value(true)));
  }

  @override
  Future<void> setCurrent(String id) async {
    await (_database.update(_database.exerciseSetTable)
          ..where((t) => t.isCurrent.equals(true)))
        .write(const ExerciseSetTableCompanion(isCurrent: Value(false)));
    await (_database.update(_database.exerciseSetTable)
          ..where((t) => t.id.equals(id)))
        .write(const ExerciseSetTableCompanion(isCurrent: Value(true)));
  }

  @override
  Future<void> deleteById(String id) async {
    final usedBy = await (_database.select(_database.powerTrainingTable)
          ..where((t) => t.exerciseSetId.equals(id))
          ..limit(1))
        .getSingleOrNull();
    if (usedBy != null) {
      throw const EntityInUseException();
    }
    await (_database.delete(_database.exerciseSetItemTable)
          ..where((t) => t.exerciseSetId.equals(id)))
        .go();
    await (_database.delete(_database.exerciseSetTable)
          ..where((t) => t.id.equals(id)))
        .go();
  }
}

import 'package:drift/drift.dart';
import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';
import 'package:storage_local_api/local_storage_api.dart';

class ExerciseRepository extends BaseExerciseRepository {
  final UuidGenerator _uuidGenerator;
  final AppDatabase _database;

  ExerciseRepository(this._uuidGenerator, this._database);

  @override
  Future<Exercise> create(Exercise exercise) async {
    final name = exercise.name.trim();
    if (name.isEmpty) {
      throw const EmptyNameException();
    }
    final existing = await (_database.select(_database.exerciseTable)
          ..where((t) => t.name.equals(name)))
        .getSingleOrNull();
    if (existing != null) {
      throw NameAlreadyExistsException(name);
    }
    final persisted = exercise.copyWith(
      id: _uuidGenerator.generateUuid(),
      name: name,
    );
    await _database.into(_database.exerciseTable).insert(
          ExerciseTableCompanion.insert(
            id: persisted.id,
            name: persisted.name,
            categoryId: persisted.categoryId,
          ),
        );
    return persisted;
  }

  @override
  Future<Iterable<Exercise>> findAll() async {
    final rows = await _database.select(_database.exerciseTable).get();
    return rows
        .map((e) => Exercise(id: e.id, name: e.name, categoryId: e.categoryId))
        .toList();
  }

  @override
  Future<void> deleteById(String id) async {
    final approach = await (_database.select(_database.powerTrainingApproachTable)
          ..where((t) => t.exerciseId.equals(id)))
        .getSingleOrNull();
    if (approach != null) {
      throw const EntityInUseException();
    }
    await (_database.delete(_database.exerciseSetItemTable)
          ..where((t) => t.exerciseId.equals(id)))
        .go();
    await (_database.delete(_database.exerciseTable)
          ..where((t) => t.id.equals(id)))
        .go();
  }
}

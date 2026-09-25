import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';
import 'package:storage_local_api/local_storage_api.dart';

class ExerciseRepository extends BaseExerciseRepository {
  final UuidGenerator _uuidGenerator;
  final AppDatabase _database;

  ExerciseRepository(this._uuidGenerator, this._database);

  @override
  Future<Exercise> create(Exercise exercise) async {
    final persisted = exercise.copyWith(id: _uuidGenerator.generateUuid());
    await _database.into(_database.exerciseTable).insert(
          ExerciseTableCompanion.insert(id: persisted.id, data: persisted),
        );
    return persisted;
  }

  @override
  Future<Exercise?> findById(String id) async {
    final row = await (_database.select(_database.exerciseTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row?.data;
  }

  @override
  Stream<Iterable<Exercise>> findAll() async* {
    yield* _database.select(_database.exerciseTable).watch().map((event) {
      return event.map((e) => e.data);
    });
  }

  /// Возвращает упражнения в порядке переданных id; неизвестные id
  /// пропускаются, порядок строк из базы не используется.
  @override
  Future<Iterable<Exercise>> findAllById(Iterable<String> ids) async {
    final orderedIds = ids.toList();
    if (orderedIds.isEmpty) {
      return const <Exercise>[];
    }

    final rows = await (_database.select(_database.exerciseTable)
          ..where((tbl) => tbl.id.isIn(orderedIds)))
        .get();
    final exerciseById = {for (final row in rows) row.id: row.data};

    return [
      for (final id in orderedIds)
        if (exerciseById[id] != null) exerciseById[id]!,
    ];
  }

  @override
  Future<void> deleteById(String id) async {
    await (_database.delete(_database.exerciseTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}

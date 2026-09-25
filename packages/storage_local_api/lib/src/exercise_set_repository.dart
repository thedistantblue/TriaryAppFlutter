import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';
import 'package:storage_local_api/local_storage_api.dart';

class ExerciseSetRepository extends BaseExerciseSetRepository {
  final UuidGenerator _uuidGenerator;
  final AppDatabase _database;

  ExerciseSetRepository(this._uuidGenerator, this._database);

  /// Сохраняет набор и его связки с упражнениями одной транзакцией.
  /// Повторяющиеся и пустые идентификаторы упражнений отбрасываются,
  /// порядок остальных сохраняется и уезжает в колонку position.
  @override
  Future<ExerciseSet> create(ExerciseSet exerciseSet) async {
    final persisted = exerciseSet.copyWith(
      id: _uuidGenerator.generateUuid(),
      exerciseIds: _distinct(exerciseSet.exerciseIds),
    );

    await _database.transaction(() async {
      await _database.into(_database.exerciseSetTable).insert(
            ExerciseSetTableCompanion.insert(id: persisted.id, data: persisted),
          );
      for (var position = 0;
          position < persisted.exerciseIds.length;
          position++) {
        await _database.into(_database.exerciseSetLinkTable).insert(
              ExerciseSetLinkTableCompanion.insert(
                setId: persisted.id,
                exerciseId: persisted.exerciseIds[position],
                position: position,
              ),
            );
      }
    });

    return persisted;
  }

  @override
  Future<ExerciseSet?> findById(String id) async {
    final row = await (_database.select(_database.exerciseSetTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row?.data;
  }

  @override
  Stream<Iterable<ExerciseSet>> findAll() async* {
    yield* _database.select(_database.exerciseSetTable).watch().map((event) {
      return event.map((e) => e.data);
    });
  }

  @override
  Future<Iterable<ExerciseSet>> findAllById(Iterable<String> ids) async {
    final orderedIds = ids.toList();
    if (orderedIds.isEmpty) {
      return const <ExerciseSet>[];
    }

    final rows = await (_database.select(_database.exerciseSetTable)
          ..where((tbl) => tbl.id.isIn(orderedIds)))
        .get();
    final setById = {for (final row in rows) row.id: row.data};

    return [
      for (final id in orderedIds)
        if (setById[id] != null) setById[id]!,
    ];
  }

  /// Удаляет набор вместе с его связками. Упражнения, входившие в набор,
  /// остаются: они принадлежат справочнику, а не набору.
  @override
  Future<void> deleteById(String id) async {
    await _database.transaction(() async {
      await (_database.delete(_database.exerciseSetLinkTable)
            ..where((tbl) => tbl.setId.equals(id)))
          .go();
      await (_database.delete(_database.exerciseSetTable)
            ..where((tbl) => tbl.id.equals(id)))
          .go();
    });
  }

  List<String> _distinct(Iterable<String> ids) {
    final result = <String>[];
    for (final id in ids) {
      if (id.isEmpty || result.contains(id)) {
        continue;
      }
      result.add(id);
    }
    return result;
  }
}

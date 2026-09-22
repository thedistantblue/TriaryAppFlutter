import 'package:drift/drift.dart';
import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';
import 'package:storage_local_api/local_storage_api.dart';

class PowerTrainingRepository extends BasePowerTrainingRepository {
  final UuidGenerator _uuidGenerator;
  final AppDatabase _database;

  PowerTrainingRepository(this._uuidGenerator, this._database);

  @override
  Future<PowerTraining> create(PowerTraining training) async {
    final persisted = training.copyWith(id: _uuidGenerator.generateUuid());
    await _database.into(_database.powerTrainingTable).insert(
          PowerTrainingTableCompanion.insert(
            id: persisted.id,
            name: persisted.name,
            description: persisted.description,
            date: Value(persisted.date),
            exerciseSetId: Value(persisted.exerciseSetId),
          ),
        );
    return persisted;
  }

  @override
  Future<PowerTraining?> findById(String id) async {
    final row = await (_database.select(_database.powerTrainingTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _map(row);
  }

  @override
  Stream<Iterable<PowerTraining>> findAll() async* {
    yield* _database.select(_database.powerTrainingTable).watch().map((event) {
      return event.map(_map);
    });
  }

  @override
  Future<Iterable<PowerTraining>> findAllById(Iterable<String> ids) async {
    return (_database.select(_database.powerTrainingTable)
          ..where((tbl) => tbl.id.isIn(ids)))
        .map(_map)
        .get();
  }

  @override
  Future<Iterable<PowerTraining>> findAllSortedByDate() async {
    final trainings =
        await _database.select(_database.powerTrainingTable).map(_map).get();
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
  Future<void> deleteById(String id) async {
    await (_database.delete(_database.powerTrainingApproachTable)
          ..where((t) => t.powerTrainingId.equals(id)))
        .go();
    await (_database.delete(_database.powerTrainingTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<void> setDate(String id, DateTime date) async {
    await (_database.update(_database.powerTrainingTable)
          ..where((t) => t.id.equals(id)))
        .write(PowerTrainingTableCompanion(date: Value(date)));
  }

  PowerTraining _map(PowerTrainingTableData e) => PowerTraining(
        id: e.id,
        name: e.name,
        description: e.description,
        date: e.date,
        exerciseSetId: e.exerciseSetId,
      );
}

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
            data: persisted,
            setId: Value(_setIdToSql(persisted.setId)),
          ),
        );
    return persisted;
  }

  @override
  Future<void> update(PowerTraining training) async {
    await (_database.update(_database.powerTrainingTable)
          ..where((tbl) => tbl.id.equals(training.id)))
        .write(
      PowerTrainingTableCompanion(
        data: Value(training),
        setId: Value(_setIdToSql(training.setId)),
      ),
    );
  }

  @override
  Future<PowerTraining?> findById(String id) async {
    final row = await (_database.select(_database.powerTrainingTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row?.data;
  }

  @override
  Stream<Iterable<PowerTraining>> findAll() async* {
    yield* _database.select(_database.powerTrainingTable).watch().map((event) {
      return event.map((e) => e.data);
    });
  }

  @override
  Future<Iterable<PowerTraining>> findAllById(Iterable<String> ids) async {
    return (_database.select(_database.powerTrainingTable)
          ..where((tbl) => tbl.id.isIn(ids)))
        .map((e) => e.data)
        .get();
  }

  @override
  Future<void> deleteById(String id) async {
    await (_database.delete(_database.powerTrainingTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  /// Пустая строка в сущности означает «набор не выбран»; в базе это null.
  String? _setIdToSql(String setId) => setId.isEmpty ? null : setId;
}

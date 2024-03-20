import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';
import 'package:storage_local_api/local_storage_api.dart';

class PowerTrainingRepository extends BasePowerTrainingRepository {
  final UuidGenerator _uuidGenerator;
  final AppDatabase _database;

  PowerTrainingRepository(this._uuidGenerator, this._database);

  @override
  PowerTraining create(PowerTraining training) {
    training.id = _uuidGenerator.generateUuid();
    _database.into(_database.powerTrainingTable).insert(
          PowerTrainingTableCompanion.insert(id: training.id, data: training),
        );
    return training;
  }

  @override
  Future<PowerTraining?> findById(String id) async {
    return (await (_database.select(_database.powerTrainingTable)
              ..where((tbl) => tbl.id.equals(id)))
            .getSingle())
        .data;
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
  void deleteById(String id) {
    (_database.delete(_database.powerTrainingTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}

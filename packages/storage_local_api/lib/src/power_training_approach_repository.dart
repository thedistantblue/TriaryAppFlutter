import 'package:drift/drift.dart';
import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';
import 'package:storage_local_api/local_storage_api.dart';

class PowerTrainingApproachRepository
    extends BasePowerTrainingApproachRepository {
  final UuidGenerator _uuidGenerator;
  final AppDatabase _database;

  PowerTrainingApproachRepository(this._uuidGenerator, this._database);

  @override
  Future<PowerTrainingApproach> create(PowerTrainingApproach approach) async {
    final persisted = approach.copyWith(id: _uuidGenerator.generateUuid());
    await _database.into(_database.powerTrainingApproachTable).insert(
          PowerTrainingApproachTableCompanion.insert(
            id: persisted.id,
            powerTrainingId: persisted.powerTrainingId,
            exerciseId: persisted.exerciseId,
            position: persisted.position,
            reps: persisted.reps,
            weight: persisted.weight,
            source: persisted.source,
          ),
        );
    return persisted;
  }

  @override
  Future<Iterable<PowerTrainingApproach>> findByTraining(
    String powerTrainingId,
  ) async {
    final rows = await (_database.select(_database.powerTrainingApproachTable)
          ..where((t) => t.powerTrainingId.equals(powerTrainingId))
          ..orderBy([(t) => OrderingTerm.asc(t.position)]))
        .get();
    return rows.map(_map).toList();
  }

  @override
  Future<Iterable<PowerTrainingApproach>> findByExercise(
    String exerciseId,
  ) async {
    final rows = await (_database.select(_database.powerTrainingApproachTable)
          ..where((t) => t.exerciseId.equals(exerciseId)))
        .get();
    return rows.map(_map).toList();
  }

  @override
  Future<void> deleteById(String id) async {
    await (_database.delete(_database.powerTrainingApproachTable)
          ..where((t) => t.id.equals(id)))
        .go();
  }

  PowerTrainingApproach _map(PowerTrainingApproachTableData e) =>
      PowerTrainingApproach(
        id: e.id,
        powerTrainingId: e.powerTrainingId,
        exerciseId: e.exerciseId,
        position: e.position,
        reps: e.reps,
        weight: e.weight,
        source: e.source,
      );
}

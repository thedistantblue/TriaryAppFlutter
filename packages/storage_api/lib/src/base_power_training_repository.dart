import 'package:entity/entity.dart';
import 'package:storage_api/src/base_repository.dart';

abstract class BasePowerTrainingRepository
    implements BaseRepository<PowerTraining> {
  Future<Iterable<PowerTraining>> findAllSortedByDate();

  /// Фиксирует дату завершения тренировки.
  Future<void> setDate(String id, DateTime date);
}

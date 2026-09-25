import 'package:entity/entity.dart';
import 'package:storage_api/src/base_repository.dart';

abstract class BasePowerTrainingRepository
    implements BaseRepository<PowerTraining> {
  /// Сохраняет изменения существующей тренировки. Этим методом будущая
  /// фича выбора набора проставляет ссылку на набор упражнений.
  Future<void> update(PowerTraining training);
}

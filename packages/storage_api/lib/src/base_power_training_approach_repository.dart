import 'package:entity/entity.dart';

abstract class BasePowerTrainingApproachRepository {
  Future<PowerTrainingApproach> create(PowerTrainingApproach approach);

  Future<Iterable<PowerTrainingApproach>> findByTraining(String powerTrainingId);

  Future<Iterable<PowerTrainingApproach>> findByExercise(String exerciseId);

  Future<void> deleteById(String id);
}

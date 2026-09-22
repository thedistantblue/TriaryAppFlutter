import 'package:entity/entity.dart';

abstract class BaseExerciseRepository {
  Future<Exercise> create(Exercise exercise);

  Future<Iterable<Exercise>> findAll();

  Future<void> deleteById(String id);
}

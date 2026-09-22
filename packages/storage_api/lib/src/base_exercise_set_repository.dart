import 'package:entity/entity.dart';

abstract class BaseExerciseSetRepository {
  Future<ExerciseSet> create(ExerciseSet set);

  Future<Iterable<ExerciseSet>> findAll();

  Future<Iterable<ExerciseSetItem>> findAllItems(String setId);

  Future<void> addItem(String setId, String exerciseId);

  Future<void> reorder(String setId, Iterable<String> exerciseIds);

  Future<void> softDeleteItem(String setId, String exerciseId);

  Future<void> setCurrent(String id);

  Future<void> deleteById(String id);
}

import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';

class ExerciseRepositoryMock implements BaseExerciseRepository {
  final UuidGenerator _uuidGenerator;
  final Map<String, Exercise> _idToExerciseMap = {};

  ExerciseRepositoryMock(this._uuidGenerator);

  @override
  Future<Exercise> create(Exercise exercise) async {
    final persisted = exercise.copyWith(id: _uuidGenerator.generateUuid());
    _idToExerciseMap[persisted.id] = persisted;
    return persisted;
  }

  @override
  Future<Exercise?> findById(String id) {
    return Future.delayed(
        const Duration(milliseconds: 2), () => _idToExerciseMap[id]);
  }

  @override
  Stream<Iterable<Exercise>> findAll() {
    return Stream.value(_idToExerciseMap.values);
  }

  @override
  Future<Iterable<Exercise>> findAllById(Iterable<String> ids) {
    return Future.delayed(
      const Duration(milliseconds: 2),
      () {
        final List<Exercise> exercises = [];
        for (var e in ids) {
          var exercise = _idToExerciseMap[e];
          if (exercise != null) {
            exercises.add(exercise);
          }
        }
        return exercises;
      },
    );
  }

  @override
  Future<void> deleteById(String id) async {
    await Future.delayed(const Duration(milliseconds: 2));
    _idToExerciseMap.remove(id);
  }
}

import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';

class ExerciseSetRepositoryMock implements BaseExerciseSetRepository {
  final UuidGenerator _uuidGenerator;
  final Map<String, ExerciseSet> _idToSetMap = {};

  ExerciseSetRepositoryMock(this._uuidGenerator);

  @override
  Future<ExerciseSet> create(ExerciseSet exerciseSet) async {
    final persisted = exerciseSet.copyWith(id: _uuidGenerator.generateUuid());
    _idToSetMap[persisted.id] = persisted;
    return persisted;
  }

  @override
  Future<ExerciseSet?> findById(String id) {
    return Future.delayed(
        const Duration(milliseconds: 2), () => _idToSetMap[id]);
  }

  @override
  Stream<Iterable<ExerciseSet>> findAll() {
    return Stream.value(_idToSetMap.values);
  }

  @override
  Future<Iterable<ExerciseSet>> findAllById(Iterable<String> ids) {
    return Future.delayed(
      const Duration(milliseconds: 2),
      () {
        final List<ExerciseSet> exerciseSets = [];
        for (var e in ids) {
          var exerciseSet = _idToSetMap[e];
          if (exerciseSet != null) {
            exerciseSets.add(exerciseSet);
          }
        }
        return exerciseSets;
      },
    );
  }

  @override
  Future<void> deleteById(String id) async {
    await Future.delayed(const Duration(milliseconds: 2));
    _idToSetMap.remove(id);
  }
}

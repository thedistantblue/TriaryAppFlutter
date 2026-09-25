import 'package:entity/entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_api/storage_api.dart';

part 'workout_event.dart';

part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final BaseExerciseSetRepository _exerciseSetRepository;
  final BaseExerciseRepository _exerciseRepository;

  WorkoutBloc(this._exerciseSetRepository, this._exerciseRepository)
      : super(const WorkoutState()) {
    on<WorkoutStarted>(_onWorkoutStarted);
    on<SetExpansionToggled>(_onSetExpansionToggled);
  }

  /// Набор читается по ссылке тренировки, упражнения — по списку id набора
  /// (в том же порядке). Пустая ссылка, отсутствующий набор и пустой список
  /// упражнений — не ошибки, а состояние «набор не выбран».
  Future<void> _onWorkoutStarted(
    WorkoutStarted event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      if (event.training.setId.isEmpty) {
        emit(state.copyWith(status: WorkoutStatus.success));
        return;
      }

      final exerciseSet =
          await _exerciseSetRepository.findById(event.training.setId);
      final exercises = exerciseSet == null
          ? <Exercise>[]
          : (await _exerciseRepository.findAllById(exerciseSet.exerciseIds))
              .toList();

      emit(state.copyWith(
        status: WorkoutStatus.success,
        exerciseSet: exerciseSet,
        exercises: exercises,
      ));
    } catch (_) {
      emit(state.copyWith(status: WorkoutStatus.failure));
    }
  }

  void _onSetExpansionToggled(
    SetExpansionToggled event,
    Emitter<WorkoutState> emit,
  ) {
    emit(state.copyWith(isExpanded: !state.isExpanded));
  }
}

part of 'power_training_execution_bloc.dart';

enum PowerTrainingExecutionStatus { initial, success, failure }

final class PowerTrainingExecutionState extends Equatable {
  final PowerTrainingExecutionStatus status;
  final PowerTraining? training;
  final List<Exercise> exercises;
  final Map<String, List<PowerTrainingApproach>> approachesByExercise;
  final int currentExerciseIndex;
  final List<PowerTrainingApproach> previousRecords;
  final String? previousExerciseId;
  final int? restRemaining;
  final int restDuration;
  final bool finished;
  final Object? error;

  const PowerTrainingExecutionState({
    this.status = PowerTrainingExecutionStatus.initial,
    this.training,
    this.exercises = const <Exercise>[],
    this.approachesByExercise =
        const <String, List<PowerTrainingApproach>>{},
    this.currentExerciseIndex = 0,
    this.previousRecords = const <PowerTrainingApproach>[],
    this.previousExerciseId,
    this.restRemaining,
    this.restDuration = 0,
    this.finished = false,
    this.error,
  });

  Exercise? get currentExercise =>
      (currentExerciseIndex >= 0 && currentExerciseIndex < exercises.length)
          ? exercises[currentExerciseIndex]
          : null;

  PowerTrainingExecutionState copyWith({
    PowerTrainingExecutionStatus? status,
    Object? training = _unset,
    List<Exercise>? exercises,
    Map<String, List<PowerTrainingApproach>>? approachesByExercise,
    int? currentExerciseIndex,
    List<PowerTrainingApproach>? previousRecords,
    Object? previousExerciseId = _unset,
    Object? restRemaining = _unset,
    int? restDuration,
    bool? finished,
    Object? error = _unset,
  }) {
    return PowerTrainingExecutionState(
      status: status ?? this.status,
      training: identical(training, _unset)
          ? this.training
          : training as PowerTraining?,
      exercises: exercises ?? this.exercises,
      approachesByExercise: approachesByExercise ?? this.approachesByExercise,
      currentExerciseIndex: currentExerciseIndex ?? this.currentExerciseIndex,
      previousRecords: previousRecords ?? this.previousRecords,
      previousExerciseId: identical(previousExerciseId, _unset)
          ? this.previousExerciseId
          : previousExerciseId as String?,
      restRemaining: identical(restRemaining, _unset)
          ? this.restRemaining
          : restRemaining as int?,
      restDuration: restDuration ?? this.restDuration,
      finished: finished ?? this.finished,
      error: identical(error, _unset) ? this.error : error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        training,
        exercises,
        approachesByExercise,
        currentExerciseIndex,
        previousRecords,
        previousExerciseId,
        restRemaining,
        restDuration,
        finished,
        error,
      ];
}

const Object _unset = Object();

part of 'power_training_execution_bloc.dart';

sealed class PowerTrainingExecutionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class PowerTrainingExecutionStarted extends PowerTrainingExecutionEvent {
  final String trainingId;
  PowerTrainingExecutionStarted(this.trainingId);

  @override
  List<Object?> get props => [trainingId];
}

final class PowerTrainingApproachAdded extends PowerTrainingExecutionEvent {
  final String exerciseId;
  final int reps;
  final double weight;
  PowerTrainingApproachAdded({
    required this.exerciseId,
    required this.reps,
    required this.weight,
  });

  @override
  List<Object?> get props => [exerciseId, reps, weight];
}

final class PowerTrainingApproachRemoved extends PowerTrainingExecutionEvent {
  final String approachId;
  PowerTrainingApproachRemoved(this.approachId);

  @override
  List<Object?> get props => [approachId];
}

final class PowerTrainingNextExercise extends PowerTrainingExecutionEvent {}

final class PowerTrainingPreviousRequested extends PowerTrainingExecutionEvent {
  final String exerciseId;
  PowerTrainingPreviousRequested(this.exerciseId);

  @override
  List<Object?> get props => [exerciseId];
}

final class PowerTrainingPreviousApplied extends PowerTrainingExecutionEvent {
  final String exerciseId;
  final List<PowerTrainingApproach> source;
  PowerTrainingPreviousApplied(this.exerciseId, this.source);

  @override
  List<Object?> get props => [exerciseId, source];
}

final class PowerTrainingExecutionFinished extends PowerTrainingExecutionEvent {}

final class RestTimerStarted extends PowerTrainingExecutionEvent {
  final int seconds;
  RestTimerStarted(this.seconds);

  @override
  List<Object?> get props => [seconds];
}

final class RestTimerCancelled extends PowerTrainingExecutionEvent {}

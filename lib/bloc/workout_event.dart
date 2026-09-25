part of 'workout_bloc.dart';

sealed class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

final class WorkoutStarted extends WorkoutEvent {
  const WorkoutStarted(this.training);

  final PowerTraining training;

  @override
  List<Object> get props => [training];
}

final class SetExpansionToggled extends WorkoutEvent {
  const SetExpansionToggled();
}

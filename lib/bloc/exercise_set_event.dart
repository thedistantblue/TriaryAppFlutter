part of 'exercise_set_bloc.dart';

sealed class ExerciseSetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ExerciseSetsLoaded extends ExerciseSetEvent {}

final class ExerciseSetCreated extends ExerciseSetEvent {
  final ExerciseSet set;
  ExerciseSetCreated(this.set);

  @override
  List<Object?> get props => [set];
}

final class ExerciseSetCurrentChanged extends ExerciseSetEvent {
  final String id;
  ExerciseSetCurrentChanged(this.id);

  @override
  List<Object?> get props => [id];
}

final class ExerciseSetItemAdded extends ExerciseSetEvent {
  final String setId;
  final String exerciseId;
  ExerciseSetItemAdded(this.setId, this.exerciseId);

  @override
  List<Object?> get props => [setId, exerciseId];
}

final class ExerciseSetItemRemoved extends ExerciseSetEvent {
  final String setId;
  final String exerciseId;
  ExerciseSetItemRemoved(this.setId, this.exerciseId);

  @override
  List<Object?> get props => [setId, exerciseId];
}

final class ExerciseSetItemsReordered extends ExerciseSetEvent {
  final String setId;
  final List<String> exerciseIds;
  ExerciseSetItemsReordered(this.setId, this.exerciseIds);

  @override
  List<Object?> get props => [setId, exerciseIds];
}

final class ExerciseSetDeleted extends ExerciseSetEvent {
  final String id;
  ExerciseSetDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

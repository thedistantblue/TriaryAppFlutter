part of 'exercise_catalog_bloc.dart';

sealed class ExerciseCatalogEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ExerciseCatalogLoaded extends ExerciseCatalogEvent {}

final class ExerciseCategoryAdded extends ExerciseCatalogEvent {
  final Category category;
  ExerciseCategoryAdded(this.category);

  @override
  List<Object?> get props => [category];
}

final class ExerciseAdded extends ExerciseCatalogEvent {
  final Exercise exercise;
  ExerciseAdded(this.exercise);

  @override
  List<Object?> get props => [exercise];
}

final class ExerciseCategoryDeleted extends ExerciseCatalogEvent {
  final String id;
  ExerciseCategoryDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

final class ExerciseDeleted extends ExerciseCatalogEvent {
  final String id;
  ExerciseDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

part of 'exercise_catalog_bloc.dart';

enum ExerciseCatalogStatus { initial, success, failure }

final class ExerciseCatalogState extends Equatable {
  final ExerciseCatalogStatus status;
  final List<Category> categories;
  final List<Exercise> exercises;
  final Object? error;

  const ExerciseCatalogState({
    this.status = ExerciseCatalogStatus.initial,
    this.categories = const <Category>[],
    this.exercises = const <Exercise>[],
    this.error,
  });

  ExerciseCatalogState copyWith({
    ExerciseCatalogStatus? status,
    List<Category>? categories,
    List<Exercise>? exercises,
    Object? error = _unset,
  }) {
    return ExerciseCatalogState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      exercises: exercises ?? this.exercises,
      error: identical(error, _unset) ? this.error : error,
    );
  }

  @override
  List<Object?> get props => [status, categories, exercises, error];
}

const Object _unset = Object();

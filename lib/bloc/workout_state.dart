part of 'workout_bloc.dart';

enum WorkoutStatus { initial, success, failure }

final class WorkoutState extends Equatable {
  const WorkoutState({
    this.status = WorkoutStatus.initial,
    this.exerciseSet,
    this.exercises = const <Exercise>[],
    this.isExpanded = true,
  });

  final WorkoutStatus status;

  /// null — набор не выбран (нет ссылки, набор не найден).
  final ExerciseSet? exerciseSet;
  final List<Exercise> exercises;
  final bool isExpanded;

  WorkoutState copyWith({
    WorkoutStatus? status,
    ExerciseSet? exerciseSet,
    List<Exercise>? exercises,
    bool? isExpanded,
  }) {
    return WorkoutState(
      status: status ?? this.status,
      exerciseSet: exerciseSet ?? this.exerciseSet,
      exercises: exercises ?? this.exercises,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  /// В props идёт id набора: идентичность набора задаётся его id,
  /// а nullable-поле в List<Object> не помещается.
  @override
  List<Object> get props => [
        status,
        exerciseSet?.id ?? '',
        exercises,
        isExpanded,
      ];
}

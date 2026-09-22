part of 'exercise_set_bloc.dart';

enum ExerciseSetStatus { initial, success, failure }

final class ExerciseSetState extends Equatable {
  final ExerciseSetStatus status;
  final List<ExerciseSet> sets;
  final Map<String, List<ExerciseSetItem>> itemsBySet;
  final Object? error;

  const ExerciseSetState({
    this.status = ExerciseSetStatus.initial,
    this.sets = const <ExerciseSet>[],
    this.itemsBySet = const <String, List<ExerciseSetItem>>{},
    this.error,
  });

  ExerciseSetState copyWith({
    ExerciseSetStatus? status,
    List<ExerciseSet>? sets,
    Map<String, List<ExerciseSetItem>>? itemsBySet,
    Object? error = _unset,
  }) {
    return ExerciseSetState(
      status: status ?? this.status,
      sets: sets ?? this.sets,
      itemsBySet: itemsBySet ?? this.itemsBySet,
      error: identical(error, _unset) ? this.error : error,
    );
  }

  @override
  List<Object?> get props => [status, sets, itemsBySet, error];
}

const Object _unset = Object();

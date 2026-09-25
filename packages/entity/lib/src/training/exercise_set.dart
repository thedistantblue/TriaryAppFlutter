import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_set.g.dart';

@JsonSerializable()
class ExerciseSet with Equatable {
  ExerciseSet({
    this.id = '',
    required this.name,
    this.exerciseIds = const <String>[],
  });

  final String id;
  final String name;
  final List<String> exerciseIds;

  ExerciseSet copyWith({
    String? id,
    String? name,
    List<String>? exerciseIds,
  }) =>
      ExerciseSet(
        id: id ?? this.id,
        name: name ?? this.name,
        exerciseIds: exerciseIds ?? this.exerciseIds,
      );

  factory ExerciseSet.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSetFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseSetToJson(this);

  @override
  List<Object> get props => [id, name, exerciseIds];
}

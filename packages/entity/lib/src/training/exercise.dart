import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

@JsonSerializable()
class Exercise with Equatable {
  Exercise({
    this.id = '',
    required this.name,
    required this.sets,
    required this.reps,
  });

  final String id;
  final String name;
  final int sets;
  final int reps;

  Exercise copyWith({String? id, String? name, int? sets, int? reps}) =>
      Exercise(
        id: id ?? this.id,
        name: name ?? this.name,
        sets: sets ?? this.sets,
        reps: reps ?? this.reps,
      );

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  @override
  List<Object> get props => [id, name, sets, reps];
}

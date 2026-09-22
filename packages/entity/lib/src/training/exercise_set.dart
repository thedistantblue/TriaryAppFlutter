import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_set.g.dart';

@JsonSerializable()
class ExerciseSet with Equatable {
  ExerciseSet({
    this.id = '',
    required this.name,
    this.description,
    this.isCurrent = false,
  });

  final String id;
  final String name;
  final String? description;
  final bool isCurrent;

  ExerciseSet copyWith({
    String? id,
    String? name,
    Object? description = _unset,
    bool? isCurrent,
  }) =>
      ExerciseSet(
        id: id ?? this.id,
        name: name ?? this.name,
        description: identical(description, _unset)
            ? this.description
            : description as String?,
        isCurrent: isCurrent ?? this.isCurrent,
      );

  factory ExerciseSet.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSetFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseSetToJson(this);

  @override
  List<Object?> get props => [id, name, description, isCurrent];
}

const Object _unset = Object();

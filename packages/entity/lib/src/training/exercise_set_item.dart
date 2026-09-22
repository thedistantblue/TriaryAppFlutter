import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_set_item.g.dart';

@JsonSerializable()
class ExerciseSetItem with Equatable {
  ExerciseSetItem({
    this.id = '',
    required this.exerciseSetId,
    required this.exerciseId,
    this.position = 0,
    this.isDeleted = false,
  });

  final String id;
  final String exerciseSetId;
  final String exerciseId;
  final int position;
  final bool isDeleted;

  ExerciseSetItem copyWith({
    String? id,
    String? exerciseSetId,
    String? exerciseId,
    int? position,
    bool? isDeleted,
  }) =>
      ExerciseSetItem(
        id: id ?? this.id,
        exerciseSetId: exerciseSetId ?? this.exerciseSetId,
        exerciseId: exerciseId ?? this.exerciseId,
        position: position ?? this.position,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory ExerciseSetItem.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSetItemFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseSetItemToJson(this);

  @override
  List<Object> get props => [id, exerciseSetId, exerciseId, position, isDeleted];
}

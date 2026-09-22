// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_set_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseSetItem _$ExerciseSetItemFromJson(Map<String, dynamic> json) =>
    ExerciseSetItem(
      id: json['id'] as String? ?? '',
      exerciseSetId: json['exerciseSetId'] as String,
      exerciseId: json['exerciseId'] as String,
      position: (json['position'] as num?)?.toInt() ?? 0,
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$ExerciseSetItemToJson(ExerciseSetItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exerciseSetId': instance.exerciseSetId,
      'exerciseId': instance.exerciseId,
      'position': instance.position,
      'isDeleted': instance.isDeleted,
    };

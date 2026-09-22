// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseSet _$ExerciseSetFromJson(Map<String, dynamic> json) => ExerciseSet(
  id: json['id'] as String? ?? '',
  name: json['name'] as String,
  description: json['description'] as String?,
  isCurrent: json['isCurrent'] as bool? ?? false,
);

Map<String, dynamic> _$ExerciseSetToJson(ExerciseSet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isCurrent': instance.isCurrent,
    };

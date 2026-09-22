// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'power_training.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PowerTraining _$PowerTrainingFromJson(Map<String, dynamic> json) =>
    PowerTraining(
      id: json['id'] as String? ?? '',
      name: json['name'] as String,
      description: json['description'] as String,
      date: json['date'] == null
          ? null
          : DateTime.parse(json['date'] as String),
      exerciseSetId: json['exerciseSetId'] as String?,
    );

Map<String, dynamic> _$PowerTrainingToJson(PowerTraining instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'date': instance.date?.toIso8601String(),
      'exerciseSetId': instance.exerciseSetId,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'power_training.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PowerTraining _$PowerTrainingFromJson(Map<String, dynamic> json) =>
    PowerTraining(
      json['name'] as String,
      json['description'] as String,
    )..id = json['id'] as String;

Map<String, dynamic> _$PowerTrainingToJson(PowerTraining instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

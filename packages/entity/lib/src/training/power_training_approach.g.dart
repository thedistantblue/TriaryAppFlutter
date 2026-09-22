// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'power_training_approach.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PowerTrainingApproach _$PowerTrainingApproachFromJson(
  Map<String, dynamic> json,
) => PowerTrainingApproach(
  id: json['id'] as String? ?? '',
  powerTrainingId: json['powerTrainingId'] as String,
  exerciseId: json['exerciseId'] as String,
  position: (json['position'] as num?)?.toInt() ?? 0,
  reps: (json['reps'] as num?)?.toInt() ?? 0,
  weight: (json['weight'] as num?)?.toDouble() ?? 0,
  source:
      $enumDecodeNullable(_$ApproachSourceEnumMap, json['source']) ??
      ApproachSource.manual,
);

Map<String, dynamic> _$PowerTrainingApproachToJson(
  PowerTrainingApproach instance,
) => <String, dynamic>{
  'id': instance.id,
  'powerTrainingId': instance.powerTrainingId,
  'exerciseId': instance.exerciseId,
  'position': instance.position,
  'reps': instance.reps,
  'weight': instance.weight,
  'source': _$ApproachSourceEnumMap[instance.source]!,
};

const _$ApproachSourceEnumMap = {
  ApproachSource.manual: 'manual',
  ApproachSource.applied: 'applied',
};

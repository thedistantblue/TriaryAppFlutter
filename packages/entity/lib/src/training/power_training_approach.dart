import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'power_training_approach.g.dart';

enum ApproachSource { manual, applied }

@JsonSerializable()
class PowerTrainingApproach with Equatable {
  PowerTrainingApproach({
    this.id = '',
    required this.powerTrainingId,
    required this.exerciseId,
    this.position = 0,
    this.reps = 0,
    this.weight = 0,
    this.source = ApproachSource.manual,
  });

  final String id;
  final String powerTrainingId;
  final String exerciseId;
  final int position;
  final int reps;
  final double weight;
  final ApproachSource source;

  PowerTrainingApproach copyWith({
    String? id,
    String? powerTrainingId,
    String? exerciseId,
    int? position,
    int? reps,
    double? weight,
    ApproachSource? source,
  }) =>
      PowerTrainingApproach(
        id: id ?? this.id,
        powerTrainingId: powerTrainingId ?? this.powerTrainingId,
        exerciseId: exerciseId ?? this.exerciseId,
        position: position ?? this.position,
        reps: reps ?? this.reps,
        weight: weight ?? this.weight,
        source: source ?? this.source,
      );

  factory PowerTrainingApproach.fromJson(Map<String, dynamic> json) =>
      _$PowerTrainingApproachFromJson(json);

  Map<String, dynamic> toJson() => _$PowerTrainingApproachToJson(this);

  @override
  List<Object> get props =>
      [id, powerTrainingId, exerciseId, position, reps, weight, source];
}

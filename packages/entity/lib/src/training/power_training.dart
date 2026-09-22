import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'power_training.g.dart';

@JsonSerializable()
class PowerTraining with Equatable {
  PowerTraining({
    this.id = '',
    required this.name,
    required this.description,
    this.date,
    this.exerciseSetId,
  });

  final String id;
  final String name;
  final String description;
  final DateTime? date;
  final String? exerciseSetId;

  PowerTraining copyWith({
    String? id,
    String? name,
    String? description,
    Object? date = _unset,
    Object? exerciseSetId = _unset,
  }) =>
      PowerTraining(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        date: identical(date, _unset) ? this.date : date as DateTime?,
        exerciseSetId: identical(exerciseSetId, _unset)
            ? this.exerciseSetId
            : exerciseSetId as String?,
      );

  factory PowerTraining.fromJson(Map<String, dynamic> json) =>
      _$PowerTrainingFromJson(json);

  Map<String, dynamic> toJson() => _$PowerTrainingToJson(this);

  @override
  List<Object?> get props => [id, name, description, date, exerciseSetId];
}

const Object _unset = Object();

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'power_training.g.dart';

@JsonSerializable()
class PowerTraining with Equatable {
  PowerTraining({this.id = '', required this.name, required this.description});

  final String id;
  final String name;
  final String description;

  PowerTraining copyWith({String? id, String? name, String? description}) =>
      PowerTraining(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  factory PowerTraining.fromJson(Map<String, dynamic> json) =>
      _$PowerTrainingFromJson(json);

  Map<String, dynamic> toJson() => _$PowerTrainingToJson(this);

  @override
  List<Object> get props => [id, name, description];
}

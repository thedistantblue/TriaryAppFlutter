import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'power_training.g.dart';

@JsonSerializable()
class PowerTraining with EquatableMixin {
  PowerTraining(this.name, this.description);

  late final String id;
  final String name;
  final String description;

  factory PowerTraining.fromJson(Map<String, dynamic> json) =>
      _$PowerTrainingFromJson(json);

  Map<String, dynamic> toJson() => _$PowerTrainingToJson(this);

  @override
  List<Object> get props => [id, name, description];
}
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

@JsonSerializable()
class Exercise with Equatable {
  Exercise({this.id = '', required this.name, required this.categoryId});

  final String id;
  final String name;
  final String categoryId;

  Exercise copyWith({String? id, String? name, String? categoryId}) => Exercise(
        id: id ?? this.id,
        name: name ?? this.name,
        categoryId: categoryId ?? this.categoryId,
      );

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  @override
  List<Object> get props => [id, name, categoryId];
}

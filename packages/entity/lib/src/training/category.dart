import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category with Equatable {
  Category({this.id = '', required this.name, this.parentId});

  final String id;
  final String name;
  final String? parentId;

  Category copyWith({
    String? id,
    String? name,
    Object? parentId = _unset,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        parentId:
            identical(parentId, _unset) ? this.parentId : parentId as String?,
      );

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object?> get props => [id, name, parentId];
}

const Object _unset = Object();

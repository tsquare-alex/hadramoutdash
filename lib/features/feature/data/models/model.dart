import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class Model extends Equatable {
  final int id;
  final String name;
 

  const Model({
    required this.id,
    required this.name,

  });

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModelToJson(this);

  @override
  List<Object> get props => [id, name];
}

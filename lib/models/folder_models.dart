import 'package:json_annotation/json_annotation.dart';
part 'folder_models.g.dart';

@JsonSerializable()
class FolderModel {
  final int id;
  final String name;
  FolderModel({required this.id, required this.name});
  factory FolderModel.fromJson(Map<String, dynamic> json) =>
      _$FolderModelFromJson(json);

  Map<String, dynamic> toJson() => _$FolderModelToJson(this);
}

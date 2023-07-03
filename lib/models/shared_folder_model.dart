import 'package:json_annotation/json_annotation.dart';
import 'package:snapcrate/models/folder_models.dart';
import 'package:snapcrate/models/user_model.dart';
part 'shared_folder_model.g.dart';

@JsonSerializable()
class SharedFolderModel {
  final int id;
  final bool enableEditing;
  final FolderModel folder;
  final UserModel user;
  SharedFolderModel(
      {required this.id,
      required this.enableEditing,
      required this.folder,
      required this.user});
  factory SharedFolderModel.fromJson(Map<String, dynamic> json) =>
      _$SharedFolderModelFromJson(json);
  Map<String, dynamic> toJson() => _$SharedFolderModelToJson(this);
}

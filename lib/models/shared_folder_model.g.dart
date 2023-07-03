// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_folder_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharedFolderModel _$SharedFolderModelFromJson(Map<String, dynamic> json) =>
    SharedFolderModel(
      id: json['id'] as int,
      enableEditing: json['enableEditing'] as bool,
      folder: FolderModel.fromJson(json['folder'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SharedFolderModelToJson(SharedFolderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enableEditing': instance.enableEditing,
      'folder': instance.folder,
      'user': instance.user,
    };

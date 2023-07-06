import 'package:json_annotation/json_annotation.dart';
part 'image_model.g.dart';

@JsonSerializable()
class ImageModel {
  final int imageId;
  final String name;
  final String imageUrl;
  final String thumbnailUrl;
  ImageModel(
      {required this.imageId,
      required this.name,
      required this.imageUrl,
      required this.thumbnailUrl});
  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}

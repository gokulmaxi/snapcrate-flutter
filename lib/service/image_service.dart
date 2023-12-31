import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:snapcrate/models/image_model.dart';
import 'package:snapcrate/utils/debug_logger.dart';
import 'package:snapcrate/utils/dio_client.dart';

class ImageHandler extends GetxController {
  final imageList = <ImageModel>[].obs;
  Future<void> getImageFromFolder(int folderId) async {
    try {
      final responseRaw = await Api().dio.get("/api/Folders/$folderId");
      dLog("message");
      if (responseRaw.statusCode == 200) {
        imageList.value = List<ImageModel>.from(
            responseRaw.data.map((e) => ImageModel.fromJson(e)));
        return;
      } else {
        return Future.error("Failed to fetch data");
      }
    } catch (error) {
      dLog(error);
      return Future.error("error: ${error.toString()}");
    }
  }

  Future<void> deleteImage(int imageId) async {
    try {
      final response = await Api().dio.delete("/api/Images/$imageId");
      if (response.statusCode == 204) {
        Get.back();
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<void> saveImage(ImageModel imageData) async {
    dLog(imageData.imageUrl);
  }

  Future<void> uploadImageWithFormData(int folderId, ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);

    if (image == null) {
      return; // No image selected
    }
    FormData formData = FormData.fromMap({
      'folderId': folderId,
      'files': await MultipartFile.fromFile(image.path),
    });

    try {
      final response = await Api().dio.post(
            '/api/Images/Upload', // Replace with your upload URL
            data: formData,
          );

      // Handle the response
      print(response.data);
      getImageFromFolder(folderId);
    } catch (e) {
      // Handle the error
      print(e.toString());
    }
  }

  Future<void> uploadImagesWithFormData(int folderId) async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();

    if (images == null || images.isEmpty) {
      return; // No images selected
    }

    List<MultipartFile> multipartFiles = [];

    for (XFile image in images) {
      FormData formData = FormData.fromMap({
        'folderId': folderId,
        'files': await MultipartFile.fromFile(image.path),
      });

      try {
        final response = await Api().dio.post(
              '/api/Images/Upload', // Replace with your upload URL
              data: formData,
            );

        // Handle the response
        print(response.data);
        getImageFromFolder(folderId);
      } catch (e) {
        // Handle the error
        print(e.toString());
      }
    }
  }
}

import 'package:get/get.dart';
import 'package:snapcrate/models/folder_models.dart';
import 'package:snapcrate/utils/debug_logger.dart';
import 'package:snapcrate/utils/dio_client.dart';

class SharedFoldersHandler extends GetxController {
  final folderList = <FolderModel>[].obs;
  Future<void> getFolders() async {
    try {
      final responseRaw = await Api().dio.get("/api/Folders");
      if (responseRaw.statusCode == 200) {
        folderList.value = List<FolderModel>.from(
            responseRaw.data.map((e) => FolderModel.fromJson(e)));
        return;
      } else {
        return Future.error("Failed to fetch data");
      }
    } catch (error) {
      dLog(error);
      return Future.error("error: ${error.toString()}");
    }
  }

  Future<void> createFolder(String name) async {
    try {
      dLog("Creating folder $name");
      final response =
          await Api().dio.post("/api/Folders", data: {"name": name});
      if (response.statusCode == 201) {
        getFolders();
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<void> deleteFolder(int id) async {
    try {
      final response = await Api().dio.delete("/api/Folders/$id");
      if (response.statusCode == 204) {
        getFolders();
      }
    } catch (err) {
      return Future.error(err);
    }
  }
}

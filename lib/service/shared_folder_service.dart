import 'package:get/get.dart';
import 'package:snapcrate/models/shared_folder_model.dart';
import 'package:snapcrate/models/user_model.dart';
import 'package:snapcrate/utils/debug_logger.dart';
import 'package:snapcrate/utils/dio_client.dart';

class SharedFoldersHandler extends GetxController {
  final folderList = <SharedFolderModel>[].obs;
  final userList = <UserModel>[].obs;
  final sharedUsersList = <SharedFolderModel>[].obs;
  final count = 0.obs;
  Future<void> getFolders() async {
    try {
      final responseRaw = await Api().dio.get("/api/SharedFolder");
      if (responseRaw.statusCode == 200) {
        dLog(responseRaw.data);
        folderList.value = List<SharedFolderModel>.from(
            responseRaw.data.map((e) => SharedFolderModel.fromJson(e)));
        return;
      } else {
        return Future.error("Failed to fetch data");
      }
    } catch (error) {
      dLog(error);
      return Future.error("error: ${error.toString()}");
    }
  }

  Future<void> getUsers(int folderId) async {
    try {
      await getUsersByFolder(folderId);
      final responseRaw = await Api().dio.get("/api/Auth/users");
      if (responseRaw.statusCode == 200) {
        dLog(responseRaw.data);
        userList.value = List<UserModel>.from(
            responseRaw.data.map((e) => UserModel.fromJson(e)));
        return;
      } else {
        return Future.error("Failed to fetch data");
      }
    } catch (error) {
      dLog(error);
      return Future.error("error: ${error.toString()}");
    }
  }

  Future<void> getUsersByFolder(int id) async {
    try {
      final responseRaw = await Api().dio.get("/api/SharedFolder/ByFolder/$id");
      if (responseRaw.statusCode == 200) {
        dLog(responseRaw.data);
        sharedUsersList.value = List<SharedFolderModel>.from(
            responseRaw.data.map((e) => SharedFolderModel.fromJson(e)));
        return;
      } else {
        return Future.error("Failed to fetch data");
      }
    } catch (error) {
      dLog(error);
      return Future.error("error: ${error.toString()}");
    }
  }

  Future<void> addToSharedFolder(String userName, int folderId) async {
    try {
      dLog("Creating folder $userName");
      final response = await Api().dio.post("/api/SharedFolder",
          data: {"userName": userName, "folderId": folderId});
      if (response.statusCode == 201) {
        Get.snackbar("added user", "$userName");
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<void> removeFromSharedFolder(int id) async {
    try {
      final response = await Api().dio.delete("/api/SharedFolder/$id");
      if (response.statusCode == 204) {
        sharedUsersList.removeWhere((element) => element.id == id);
        sharedUsersList.refresh();
        dLog(sharedUsersList.value.length);
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<void> updateEditingRights(int id, bool canEdit) async {
    try {
      final response =
          await Api().dio.put("/api/SharedFolder/$id?enableEditing=$canEdit");
      if (response.statusCode == 204) {
        Get.snackbar("updated", "can edit  : $canEdit");
      }
    } catch (err) {
      return Future.error(err);
    }
  }
}

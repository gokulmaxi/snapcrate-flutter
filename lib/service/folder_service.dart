import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snapcrate/utils/debug_logger.dart';
import 'package:snapcrate/utils/globals.dart';

class FolderModel {
  String name;
  String path;
  FolderModel(this.path, this.name);
}

class FoldersListHandler extends GetxController {
  final GetStorage _box = GetStorage();
  final folderList = <String>[].obs;
  final count = 0.obs;
  increment() => count.value++;
  // add function to get user added folders
  void initFolderHandler() {
    folderList.clear();
    var values = _box.read(Globals().folderStorageToken);
    List<String> data = List<String>.from(values);
    folderList.addAll(data);
    dLog(data.runtimeType);
  }

  void addFolder() {
    _pickFolder().then((value) {
      if (value != null) {
        folderList.add(value);
        _updateFolderDb();
      }
    });
  }

  void _updateFolderDb() {
    _box.write(Globals().folderStorageToken, folderList);
  }

  void removeFolder(int index) {
    folderList.removeAt(index);
    _updateFolderDb();
  }

  Future<String?> _pickFolder() async {
    final folderPath = await FilePicker.platform.getDirectoryPath();
    if (folderPath != null) {
      dLog('Picked folder path: $folderPath');
      return folderPath;
      // Perform any further operations with the selected folder
    } else {
      // User canceled the folder selection
      dLog('No folder selected.');
      return null;
    }
  }
}

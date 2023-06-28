import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:snapcrate/utils/debug_logger.dart';

class ImageMetaData {
  final String path;
  final DateTime lastModified;
  ImageMetaData(this.path, this.lastModified);
}

class FolderStateHandler extends GetxController {
  Future<List<ImageMetaData>> getFolderState(String folderPath) async {
    final folder = Directory(folderPath);
    final List<ImageMetaData> state = [];

    if (folder.existsSync()) {
      final files = folder.listSync(recursive: false);

      for (var file in files) {
        if (file is File) {
          state.add(ImageMetaData(file.path, file.lastModifiedSync()));
        }
      }
    }
    dLog(state);
    return state;
  }

  List<String> _getNewFiles(
      Map<String, String> previousState, Map<String, String> currentState) {
    final newFiles = <String>[];

    for (var filePath in currentState.keys) {
      if (!previousState.containsKey(filePath) ||
          previousState[filePath] != currentState[filePath]) {
        newFiles.add(filePath);
      }
    }

    return newFiles;
  }

  Map<String, String> _readStateFile(String stateFilePath) {
    final stateFile = File(stateFilePath);
    final stateContent =
        stateFile.existsSync() ? stateFile.readAsStringSync() : '{}';
    final Map<String, dynamic> rawData = json.decode(stateContent);
    return Map<String, String>.from(rawData);
  }

  void _writeStateFile(String stateFilePath, Map<String, String> state) {
    final stateFile = File(stateFilePath);
    final stateContent = json.encode(state);
    stateFile.writeAsStringSync(stateContent);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapcrate/screens/onboard_screen.dart';
import 'package:snapcrate/service/auth_service.dart';
import 'package:snapcrate/service/folder_service.dart';
import 'package:snapcrate/service/image_service.dart';
import 'package:snapcrate/service/shared_folder_service.dart';
import 'package:snapcrate/widgets/loader_screen.dart';
import 'package:snapcrate/widgets/error_view.dart';

class SplashView extends StatelessWidget {
  final AuthService _authmanager = Get.put(AuthService());
  final FoldersListHandler _folderHandler = Get.put(FoldersListHandler());
  final SharedFoldersHandler _sharedFoldersHandler =
      Get.put(SharedFoldersHandler());
  final ImageHandler _imageHandler = Get.put(ImageHandler());
  Future<void> initializeSettings() async {
    _authmanager.checkLoginStatus();

    //Simulate other services for 3 seconds
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError)
            return errorView(snapshot);
          else
            return OnBoard();
        }
      },
    );
  }
}

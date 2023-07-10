import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapcrate/models/folder_models.dart';
import 'package:snapcrate/service/shared_folder_service.dart';
import 'package:snapcrate/utils/debug_logger.dart';
import 'package:snapcrate/widgets/error_view.dart';
import 'package:snapcrate/widgets/loader_screen.dart';

class SharedFolderUsersScreen extends StatefulWidget {
  const SharedFolderUsersScreen({
    super.key,
  });

  @override
  State<SharedFolderUsersScreen> createState() =>
      _SharedFolderUsersScreenState();
}

class _SharedFolderUsersScreenState extends State<SharedFolderUsersScreen> {
  @override
  Widget build(BuildContext context) {
    final FolderModel folderData = Get.arguments[0];
    final SharedFoldersHandler _sharedFolderHandler = Get.find();
    return FutureBuilder(
      future: _sharedFolderHandler.getUsers(folderData.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError)
            return errorView(snapshot);
          else {
            return Scaffold(
              appBar: AppBar(
                title: Text("${folderData.name}' users"),
              ),
              // FIXME observable not working when updating lis[[id:4fe44262-e092-4946-b888-d43cc2eaadbe][storage-account]]t
              body: Obx(() {
                return ListView.builder(
                    itemCount: _sharedFolderHandler.userList.length,
                    itemBuilder: (context, index) {
                      var userName =
                          _sharedFolderHandler.userList[index].userName;
                      var shareId = _sharedFolderHandler.sharedUsersList
                          .firstWhereOrNull(
                              (element) => element.user.userName == userName);
                      return Card(
                        child: ListTile(
                          title: Text(
                              userName + _sharedFolderHandler.count.toString()),
                          trailing: IconButton(
                              onPressed: shareId == null
                                  ? () {
                                      _sharedFolderHandler.addToSharedFolder(
                                          userName, folderData.id);
                                      Future.delayed(
                                          const Duration(milliseconds: 1000),
                                          () {
                                        setState(() {});
                                      });
                                    }
                                  : () {
                                      _sharedFolderHandler
                                          .removeFromSharedFolder(shareId.id);
                                      Future.delayed(
                                          const Duration(milliseconds: 1000),
                                          () {
                                        setState(() {});
                                      });
                                    },
                              icon: shareId == null
                                  ? const Icon(Icons.person_add)
                                  : const Icon(Icons.person_remove)),
                        ),
                      );
                    });
              }),
            );
          }
        }
      },
    );
  }
}

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
              body: Column(
                children: [
                  Obx(() {
                    return Flexible(
                      child: ListView.builder(
                          itemCount: _sharedFolderHandler.userList.length,
                          itemBuilder: (context, index) {
                            var userName =
                                _sharedFolderHandler.userList[index].userName;
                            var shareId = _sharedFolderHandler.sharedUsersList
                                .firstWhereOrNull((element) =>
                                    element.user.userName == userName);
                            return Card(
                              elevation: 4,
                              margin: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Icon(Icons.person_2_outlined),
                                  title: Text(userName),
                                  trailing: (shareId == null)
                                      ? IconButton(
                                          onPressed: () {
                                            _sharedFolderHandler
                                                .addToSharedFolder(
                                                    userName, folderData.id);
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 1000), () {
                                              setState(() {});
                                            });
                                          },
                                          icon: Container(
                                              width: 40,
                                              height: 30,
                                              child:
                                                  const Icon(Icons.person_add)))
                                      : Wrap(children: [
                                          IconButton(
                                            onPressed: () {
                                              _sharedFolderHandler
                                                  .removeFromSharedFolder(
                                                      shareId.id);
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 1000), () {
                                                setState(() {});
                                              });
                                            },
                                            icon: Icon(Icons.person_remove),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                _sharedFolderHandler
                                                    .updateEditingRights(
                                                        shareId.id,
                                                        !shareId.enableEditing);
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 1000),
                                                    () {
                                                  setState(() {});
                                                });
                                              },
                                              icon: shareId.enableEditing
                                                  ? Icon(Icons.edit_off)
                                                  : Icon(Icons.edit))
                                        ]),
                                ),
                              ),
                            );
                          }),
                    );
                  }),
                ],
              ),
            );
          }
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:snapcrate/screens/image_list_screen.dart';
import 'package:snapcrate/service/auth_service.dart';
import 'package:snapcrate/service/folder_service.dart';
import 'package:snapcrate/service/folder_state_service.dart';
import 'package:snapcrate/utils/debug_logger.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthService _authManager = Get.find();
  final FoldersListHandler _folderHandler = Get.find();
  final FolderStateHandler _folderStateHandler = Get.put(FolderStateHandler());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                _authManager.logOut();
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: Center(
        // TODO add an illustration to
        child: Obx(
          () => ListView.builder(
              itemCount: _folderHandler.folderList.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(index),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () {
                      dLog("message dissmissed pane $index");
                      _folderHandler.removeFolder(index);
                    }),
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: (context) {},
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                      Get.to(const ImageLister(),
                          arguments: [_folderHandler.folderList[index]]);
                    },
                    title: Text(_folderHandler.folderList[index]),
                  ),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _folderHandler.addFolder();
        },
        child: const Icon(Icons.add_box),
      ),
    );
  }
}

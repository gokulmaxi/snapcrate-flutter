import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapcrate/screens/home_screen.dart';
import 'package:snapcrate/screens/image_list_screen.dart';
import 'package:snapcrate/service/shared_folder_service.dart';
import 'package:snapcrate/widgets/error_view.dart';
import 'package:snapcrate/widgets/loader_screen.dart';

class SharedFoldersScreen extends StatefulWidget {
  const SharedFoldersScreen({super.key});

  @override
  State<SharedFoldersScreen> createState() => _SharedFoldersScreenState();
}

class _SharedFoldersScreenState extends State<SharedFoldersScreen> {
  final SharedFoldersHandler _sharedFolderHandler = Get.find();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _sharedFolderHandler.getFolders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return waitingView();
          } else {
            if (snapshot.hasError)
              return errorView(snapshot);
            else {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Shared Folders"),
                ),
                body: ListView.builder(
                    itemCount: _sharedFolderHandler.folderList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Get.to(const ImageLister(), arguments: [
                              _sharedFolderHandler.folderList[index].folder
                            ]);
                          },
                          title: Text(_sharedFolderHandler
                              .folderList[index].folder.name),
                        ),
                      );
                    }),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: 1,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.folder),
                      label: 'My Drive',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.folder_shared),
                      label: 'Shared',
                    ),
                  ],
                  onTap: (index) {
                    if (index == 0) {
                      Get.offAll(const HomeView());
                    }
                  },
                ),
              );
            }
          }
        });
  }
}

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
                body: LayoutBuilder(
                  builder: (context, constraints) {
                    final paddingSize = constraints.maxHeight * 0.04;
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                        ),
                        itemCount: _sharedFolderHandler.folderList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: GestureDetector(
                                onTap: () {
                                  Get.to(const ImageLister(), arguments: [
                                    _sharedFolderHandler
                                        .folderList[index].folder,
                                    _sharedFolderHandler
                                        .folderList[index].enableEditing
                                  ]);
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(100, 248, 249, 253),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            paddingSize,
                                            paddingSize,
                                            paddingSize,
                                            10),
                                        child: const Image(
                                          image: AssetImage(
                                              "assets/folder-icon.png"),
                                        ),
                                      ),
                                      Text(_sharedFolderHandler
                                          .folderList[index].folder.name)
                                    ],
                                  ),
                                )
                                // (_folderHandler.folderList[index].name),
                                ),
                          );
                        });
                  },
                ),
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

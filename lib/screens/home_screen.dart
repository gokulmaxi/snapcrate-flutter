import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:snapcrate/screens/image_list_screen.dart';
import 'package:snapcrate/screens/shared_folder_screen.dart';
import 'package:snapcrate/screens/splash_screen.dart';
import 'package:snapcrate/service/auth_service.dart';
import 'package:snapcrate/service/folder_service.dart';
import 'package:snapcrate/utils/debug_logger.dart';
import 'package:snapcrate/widgets/error_view.dart';
import 'package:snapcrate/widgets/loader_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthService _authManager = Get.find();
  final FoldersListHandler _folderHandler = Get.find();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _folderHandler.getFolders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return waitingView();
          } else {
            if (snapshot.hasError)
              return errorView(snapshot);
            else {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Home'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          _authManager.logOut();
                          Get.offAll(SplashView());
                        },
                        icon: const Icon(Icons.logout_rounded))
                  ],
                ),
                body: LayoutBuilder(
                  builder: ((context, constraints) {
                    final paddingSize = constraints.maxHeight * 0.08;
                    return Center(
                      // TODO add an illustration to
                      child: Obx(
                        () => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: SizedBox(
                                width: constraints.maxWidth * 0.9,
                                height: constraints.maxHeight * 0.2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                        image: AssetImage("assets/banner.png"),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Hello ${_authManager.user}",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 40.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: _folderHandler.folderList.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: Slidable(
                                        key: ValueKey(index),
                                        startActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            // A SlidableAction can have an icon and/or a label.
                                            SlidableAction(
                                              onPressed: (context) {
                                                _folderHandler.deleteFolder(
                                                    _folderHandler
                                                        .folderList[index].id);
                                              },
                                              backgroundColor:
                                                  const Color(0xFFFE4A49),
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: 'Delete',
                                            ),
                                          ],
                                        ),
                                        child: GestureDetector(
                                            onTap: () {
                                              Get.to(const ImageLister(),
                                                  arguments: [
                                                    _folderHandler
                                                        .folderList[index],
                                                    true
                                                  ]);
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      100, 248, 249, 253),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            paddingSize,
                                                            paddingSize,
                                                            paddingSize,
                                                            20),
                                                    child: const Image(
                                                      image: AssetImage(
                                                          "assets/folder-icon.png"),
                                                    ),
                                                  ),
                                                  Text(
                                                    _folderHandler
                                                        .folderList[index].name,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  )
                                                ],
                                              ),
                                            )
                                            // (_folderHandler.folderList[index].name),
                                            ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    // TODO use getx for this
                    buildShowDialog(context);
                  },
                  child: const Icon(Icons.add_box),
                ),
                bottomNavigationBar: BottomNavigationBar(
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
                    if (index == 1) {
                      Get.offAll(const SharedFoldersScreen());
                    }
                  },
                ),
              );
            }
          }
        });
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    final _textController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Create Folder"),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Folder Name',
                    hintText: 'Enter collection name'),
              ),
            ),
            actions: [
              ElevatedButton(
                child: const Text("submit"),
                onPressed: () {
                  dLog(_textController.text);
                  _folderHandler.createFolder(_textController.text);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

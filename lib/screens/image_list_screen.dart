import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapcrate/models/folder_models.dart';
import 'package:snapcrate/screens/shared_users_screen.dart';
import 'package:snapcrate/service/image_service.dart';
import 'package:snapcrate/utils/debug_logger.dart';
import 'package:snapcrate/widgets/error_view.dart';
import 'package:snapcrate/widgets/loader_screen.dart';

class ImageLister extends StatefulWidget {
  const ImageLister({
    super.key,
  });

  @override
  State<ImageLister> createState() => _ImageListerState();
}

class _ImageListerState extends State<ImageLister> {
  final ImageHandler _imageHandler = Get.find();
  @override
  Widget build(BuildContext context) {
    final FolderModel folderData = Get.arguments[0];
    dLog(folderData.id);
    return FutureBuilder(
      future: _imageHandler.getImageFromFolder(folderData.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError)
            return errorView(snapshot);
          else {
            return Scaffold(
              appBar: AppBar(
                title: Text(folderData.name),
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.to(const SharedFolderUsersScreen(),
                            arguments: [folderData]);
                      },
                      icon: const Icon(Icons.person_add))
                ],
              ),
              body: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    crossAxisCount: 3,
                  ),
                  itemCount: _imageHandler.imageList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Image.network(
                          _imageHandler.imageList[index].thumbnailUrl),
                    );
                  }),
              floatingActionButton: FloatingActionButton(onPressed: () {
                _imageHandler.uploadImageWithFormData(folderData.id);
              }),
            );
          }
        }
      },
    );
  }
}

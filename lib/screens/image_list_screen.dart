import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapcrate/models/folder_models.dart';
import 'package:snapcrate/service/folder_state_service.dart';
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
  @override
  Widget build(BuildContext context) {
    final FolderModel folderData = Get.arguments[0];
    return FutureBuilder(
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
              ),
              body: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    crossAxisCount: 3,
                  ),
                  itemCount: 0,
                  itemBuilder: (context, index) {
                    return Container(
                        // child: Image.file(File(data[index].path)),
                        );
                  }),
            );
          }
        }
      },
    );
  }
}

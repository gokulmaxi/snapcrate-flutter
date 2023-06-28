import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final FolderStateHandler _folderStateHandler = Get.find();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _folderStateHandler.getFolderState(Get.arguments[0]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError)
            return errorView(snapshot);
          else {
            final data = snapshot.data as List<ImageMetaData>;
            return Scaffold(
              appBar: AppBar(
                title: Text(Get.arguments[0]),
              ),
              body: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    crossAxisCount: 3,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Image.file(File(data[index].path)),
                    );
                  }),
            );
          }
        }
      },
    );
  }
}

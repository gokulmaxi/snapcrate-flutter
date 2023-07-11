import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:snapcrate/models/image_model.dart';
import 'package:snapcrate/utils/debug_logger.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageModel imageData = Get.arguments[0];
    return Scaffold(
      appBar: AppBar(
        title: Text(imageData.name),
      ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(imageData.imageUrl),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Delete',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'Download',
          ),
        ],
        onTap: (index) {
          dLog(index);
        },
      ),
    );
  }
}

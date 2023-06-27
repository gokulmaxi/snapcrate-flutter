import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageLister extends StatelessWidget {
  const ImageLister({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${Get.arguments[0]}"),
      ),
    );
  }
}

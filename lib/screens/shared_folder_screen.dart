import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapcrate/screens/home_screen.dart';

class SharedFoldersScreen extends StatefulWidget {
  const SharedFoldersScreen({super.key});

  @override
  State<SharedFoldersScreen> createState() => _SharedFoldersScreenState();
}

class _SharedFoldersScreenState extends State<SharedFoldersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Folders"),
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

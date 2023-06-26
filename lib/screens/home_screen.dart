import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapcrate/service/auth_service.dart';
import 'package:snapcrate/utils/dio_client.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthService _authManager = Get.find();
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
        child: ElevatedButton(
            onPressed: () {
              Api().dio.get("/WeatherForecast").then((value) => print(value));
            },
            child: const Text("Test")),
      ),
    );
  }
}

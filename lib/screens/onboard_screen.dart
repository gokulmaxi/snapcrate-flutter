import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapcrate/screens/home_screen.dart';
import 'package:snapcrate/screens/login_screen.dart';
import 'package:snapcrate/service/auth_service.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService _authManager = Get.find();

    return Obx(() {
      return _authManager.isLogged.value ? HomeView() : LoginScreen();
    });
  }
}

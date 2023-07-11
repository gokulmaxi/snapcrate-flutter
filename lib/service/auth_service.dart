import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:snapcrate/models/auth_models.dart';
import 'package:snapcrate/utils/dio_client.dart';
import 'package:snapcrate/utils/token_handler.dart';

class AuthService extends GetxController {
  final isLogged = false.obs;
  final user = "".obs;
  Future<bool> login(String username, String password) async {
    try {
      final responseRaw = await Api().dio.post(
        '/api/Auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (responseRaw.statusCode != 200) {
        Get.snackbar("Login failed", "Unable to reach server",
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
      var response = LoginResponse.fromJson(responseRaw.data);
      print(response.status);
      if (response.status == LoginStatus.userNotFound) {
        Get.snackbar("Login failed", "No user found",
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
      if (response.status == LoginStatus.invalidPassword) {
        Get.snackbar("Login failed", "Invalid password",
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
      isLogged.value = true;
      user.value = username;
      Get.snackbar("login", "succ");
      if (kDebugMode) {
        print(response.token);
      }
      TokenManger().saveToken(response.token);
      return true;
    } catch (error) {
      print('Login error: $error');
      return false;
    }
  }

  Future<bool> register(String username, String email, String password) async {
    try {
      print("$email - $username - $password");
      final responseRaw = await Api().dio.post(
        '/api/Auth/register',
        data: {
          'username': username,
          'email': email,
          'password': password,
        },
      );
      if (responseRaw.data['status'] != LoginStatus.success) {
        Get.snackbar("Registration failed", responseRaw.data['message'],
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
      Get.back();
      Get.snackbar("Registration complete", "login now",
          snackPosition: SnackPosition.BOTTOM);
      return true;
    } catch (error) {
      print('Login error: $error');
      return false;
    }
  }

  void logOut() {
    isLogged.value = false;
    TokenManger().removeToken();
  }

  void checkLoginStatus() {
    final token = TokenManger().getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }
}

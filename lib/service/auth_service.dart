import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:snapcrate/models/auth_models.dart';
import 'package:snapcrate/utils/dio_client.dart';
import 'package:snapcrate/utils/token_handler.dart';

class AuthService extends GetxController {
  final isLogged = false.obs;
  Future<bool> login(String username, String password) async {
    try {
      final response = await Api().dio.post(
        '/api/Auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var token = LoginResponse.fromJson(response.data);
        isLogged.value = true;
        Get.snackbar("login", "succ");
        if (kDebugMode) {
          print(token.token);
        }
        TokenManger().saveToken(token.token);
        return true;
      } else {
        return false;
      }
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

import 'package:flutter/foundation.dart';
import 'package:snapcrate/models/auth_models.dart';
import 'package:snapcrate/utils/dio_client.dart';
import 'package:snapcrate/utils/token_handler.dart';

class AuthService {
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
}

import 'package:snapcrate/utils/dio_client.dart';

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
        print(response.data);
        //TODO add token repository or some kind of persistent storage for storing token
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

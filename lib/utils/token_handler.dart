import 'package:get_storage/get_storage.dart';
import 'package:snapcrate/utils/globals.dart';

class TokenManger {
  final GetStorage _box = GetStorage();
  TokenManger._internal();
  static final _singleton = TokenManger._internal();
  factory TokenManger() => _singleton;

  Future<bool> saveToken(String? token) async {
    await _box.write(Globals().jwtStorageToken, token);
    return true;
  }

  String? getToken() {
    return _box.read(Globals().jwtStorageToken);
  }

  void eraseStorage() {
    _box.erase();
  }

  Future<void> removeToken() async {
    await _box.remove(Globals().jwtStorageToken);
  }
}

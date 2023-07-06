import 'package:flutter_dotenv/flutter_dotenv.dart';

class Globals {
  //TODO load this conf file from secret file
  Globals._internal();
  static final _singleton = Globals._internal();
  factory Globals() => _singleton;
  Future<void> initialize() async {
    await dotenv.load();
  }

  // Example getter
  String get baseUrl {
    return dotenv.env['BASE_URL'] ?? '';
  }

  String get jwtStorageToken {
    return dotenv.env['JWT_TOKEN'] ?? '';
  }

  String get folderStorageToken {
    return dotenv.env['GETX_STORAGE_TOKEN'] ?? '';
  }
}

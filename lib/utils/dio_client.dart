import 'package:dio/dio.dart';
import './globals.dart';

class Api {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: Globals().baseUrl));

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Globals().baseUrl,
      receiveTimeout: const Duration(seconds: 15000), // 15 seconds
      connectTimeout: const Duration(seconds: 15000),
      sendTimeout: const Duration(seconds: 15000),
    ));
    //TODO add interceptor for jwt
    dio.interceptors.addAll({});
    return dio;
  }
}

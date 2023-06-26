import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:snapcrate/utils/token_handler.dart';
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
    dio.interceptors.addAll({AuthInterceptor()});
    return dio;
  }
}

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // Add the authentication token to the headers of each request
    var token = TokenManger().getToken();
    print("Interceptor");
    print(token);
    // TODO route to login page if token is not found
    if (token == null) {}
    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }
}

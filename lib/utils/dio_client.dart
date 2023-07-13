import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:snapcrate/screens/splash_screen.dart';
import 'package:snapcrate/service/auth_service.dart';
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
      receiveTimeout: const Duration(seconds: 1000), // 15 seconds
      connectTimeout: const Duration(seconds: 1000),
      sendTimeout: const Duration(seconds: 1000),
    ));
    //TODO add interceptor for jwt
    dio.interceptors.addAll({AuthInterceptor(), ErrorInterceptor()});
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
    // TODO route to login page if token is not found
    if (token == null) {}
    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(err.response?.statusCode);
    if (err.response?.statusCode == 401) {
      Get.snackbar("Request Error", "Unauthorised rerquest");
      AuthService().logOut();
      Get.to(SplashView());
    }
    if (err.response?.statusCode == 404) {
      Get.snackbar("Request Error", "Resource not Found");
    }
    if (err.response?.statusCode == 400) {
      // TODO add snack bar other dialog box to show list of errors from c#
      Get.snackbar(
          "Request Error", err.response?.statusMessage ?? "Bad Request");
    }
    // if (err.) {
    if (err.response?.statusCode == 500) {
      Get.snackbar("Session expired", "Login again");
      TokenManger().eraseStorage();
      Get.offAll(SplashView());
    }

    // }

    super.onError(err, handler);
  }
}

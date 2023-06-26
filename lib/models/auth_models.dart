import 'package:json_annotation/json_annotation.dart';
part 'auth_models.g.dart';

class LoginStatus {
  static const success = "SUCCESS";
  static const userNotFound = "USER_NOT_FOUND";
  static const invalidPassword = "INCORRECT_PASSWORD";
}

@JsonSerializable()
class LoginResponse {
  final String status;
  final String token;
  final String expiration;
  LoginResponse(
      {required this.status, required this.token, required this.expiration});
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

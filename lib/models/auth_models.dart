import 'package:json_annotation/json_annotation.dart';
part 'auth_models.g.dart';

@JsonSerializable()
class LoginResponse {
  final String token;
  final String expiration;
  LoginResponse({required this.token, required this.expiration});
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

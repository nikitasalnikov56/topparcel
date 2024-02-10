class LoginResponse {
  late int status;
  late String token;

  LoginResponse({
    required this.status,
    required this.token,
  });

  LoginResponse.fromJson(dynamic json) {
    status = json['status'];
    if (status == 200) token = json['token'] ?? '';
  }
}

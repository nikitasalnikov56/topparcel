// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginRequest {
  late String login;
  late String password;

  LoginRequest({
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['email'] = login;
    map['password'] = password;
    return map;
  }
}

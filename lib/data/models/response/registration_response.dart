class RegistrationResponse {
  late String token;
  late String id;

  RegistrationResponse({
    required this.token,
    required this.id,
  });

  RegistrationResponse.fromJson(dynamic json) {
    token = json['user']['token'];
    id = json['user']['id'];
  }
}

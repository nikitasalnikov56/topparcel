class UpdatePasswordRequest {
  late String email;
  late String password;
  late String newPassword;

  UpdatePasswordRequest({
    required this.email,
    required this.password,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['new_password'] = this.newPassword;

    return data;
  }

  UpdatePasswordRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    newPassword =
        json.containsKey('new_password') ? json['new_password'] : null;
  }
}

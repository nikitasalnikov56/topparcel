class UserDetailsRequest {
  late String email;
  late String password;
  late String currency;

  UserDetailsRequest({
    required this.email,
    required this.password,
    required this.currency,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['currency'] = this.currency;
    return data;
  }

  static UserDetailsRequest emptyModel() {
    return UserDetailsRequest(
      email: '',
      password: '',
      currency: '',
    );
  }
}

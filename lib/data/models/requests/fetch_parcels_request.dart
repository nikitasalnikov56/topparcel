class FetchParcelsRequest {
  late String email;
  late String token;
  late String currency;

  FetchParcelsRequest({
    required this.email,
    required this.token,
    required this.currency,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['email'] = email;
    map['password'] = token;
    map['currency'] = currency;
    return map;
  }
}

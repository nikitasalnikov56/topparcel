// ignore_for_file: public_member_api_docs, sort_constructors_first
class FetchCountryRequest {
  late String email;
  late String token;

  FetchCountryRequest({
    required this.email,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['email'] = email;
    map['password'] = token;
    return map;
  }
}

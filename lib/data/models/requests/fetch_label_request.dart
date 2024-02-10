class FetchLabelRequest {
  late String email;
  late String token;
  late int id;

  FetchLabelRequest({
    required this.email,
    required this.token,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['email'] = email;
    map['password'] = token;
    map['id'] = id;
    return map;
  }
}

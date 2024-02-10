class RecoverRequest {
  late String email;

  RecoverRequest({required this.email});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['email'] = email;
    return map;
  }
}

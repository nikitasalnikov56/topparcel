// ignore_for_file: public_member_api_docs, sort_constructors_first
class TrackingNumberRequest {
  late String email;
  late String token;
  late String track;

  TrackingNumberRequest({
    required this.email,
    required this.token,
    required this.track,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['email'] = email;
    map['password'] = token;
    map['track'] = track;
    return map;
  }
}

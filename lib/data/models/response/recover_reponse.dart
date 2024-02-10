class RecoverResponse {
  late int status;

  RecoverResponse({
    required this.status,
  });

  RecoverResponse.fromJson(dynamic json) {
    status = json['status'];
  }
}

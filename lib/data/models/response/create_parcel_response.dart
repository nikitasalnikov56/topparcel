class CreateParcelResponse {
  late int status;

  CreateParcelResponse({required this.status});

  CreateParcelResponse.fromJson(dynamic json) {
    status = json['status'];
  }
}

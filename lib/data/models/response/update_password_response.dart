class UpdatePasswordResponse {
  late int status;
  late String description;

  UpdatePasswordResponse({
    required this.status,
    required this.description,
  });

  factory UpdatePasswordResponse.fromJson(Map<String, dynamic> json) {
    return UpdatePasswordResponse(
      status: json['status'],
      description: json['description'],
    );
  }
}

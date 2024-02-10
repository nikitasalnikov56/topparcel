class UpdateUserResponse {
  late int status;
  late String description;

  UpdateUserResponse({
    required this.status,
    required this.description,
  });

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserResponse(
      status: json['status'],
      description: json['description'],
    );
  }
}

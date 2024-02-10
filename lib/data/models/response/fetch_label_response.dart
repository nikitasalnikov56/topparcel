class FetchLabelResponse {
  late int status;
  late String description;
  late String label;

  FetchLabelResponse({
    required this.status,
    required this.description,
    required this.label,
  });

  FetchLabelResponse.fromJson(dynamic json) {
    status = json['status'];
    description = json['description'];
    label = json['label'];
  }
}

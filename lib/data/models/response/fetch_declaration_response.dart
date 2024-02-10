class FetchDeclarationResponse {
  late int status;
  late String description;
  late String documents;

  FetchDeclarationResponse({
    required this.status,
    required this.description,
    required this.documents,
  });

  FetchDeclarationResponse.fromJson(dynamic json) {
    status = json['status'];
    description = json['description'];
    documents = json['declaration'];
  }
}

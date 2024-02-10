class FetchDocumentsResponse {
  late int status;
  late String description;
  late String documents;

  FetchDocumentsResponse({
    required this.status,
    required this.description,
    required this.documents,
  });

  FetchDocumentsResponse.fromJson(dynamic json) {
    status = json['status'];
    description = json['description'];
    documents = json['documents'];
  }
}

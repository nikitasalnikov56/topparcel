class FetchInvoiceRequest {
  late String email;
  late String token;
  late int id;
  late String currency;

  FetchInvoiceRequest({
    required this.email,
    required this.token,
    required this.id,
    required this.currency,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['email'] = email;
    map['password'] = token;
    map['id'] = id;
    map['currency'] = currency;
    return map;
  }
}

class CreatePayRequest {
  late String email;
  late String token;
  late String currency;
  late int amount;
  late int typeId;

  CreatePayRequest({
    required this.email,
    required this.token,
    this.currency = 'EUR',
    required this.amount,
    required this.typeId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['email'] = email;
    map['password'] = token;
    map['currency'] = currency;
    map['amount'] = amount;
    map['type_id'] = typeId;
    return map;
  }
}

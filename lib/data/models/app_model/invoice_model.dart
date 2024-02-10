class InvoiceModel {
  late int id;
  late DateTime createdDt;
  late double total;
  late double vat;
  late int paid;
  late int typeId;
  late String number;
  late PaymentInvoiceModel? payment;

  InvoiceModel({
    required this.id,
    required this.createdDt,
    required this.total,
    required this.vat,
    required this.paid,
    required this.typeId,
    required this.number,
    required this.payment,
  });

  InvoiceModel.fromJson(dynamic json) {
    id = json['id'] ?? 0;
    createdDt = json['date_created'] != null
        ? DateTime.parse(json['date_created'])
        : DateTime.now();
    total = json['total'] ?? 0.0;
    vat = json['vat'] ?? 0.0;
    paid = json['paid'] ?? 0.0;
    typeId = json['type_id'] ?? 0.0;
    number = json['number'] ?? 0.0;
    payment = json['payment'] != null
        ? PaymentInvoiceModel.fromJson(json['payment'])
        : null;
  }
}

class PaymentInvoiceModel {
  late int id;
  late int typeId;
  late double total;
  late int approved;

  PaymentInvoiceModel({
    required this.id,
    required this.typeId,
    required this.total,
    required this.approved,
  });

  PaymentInvoiceModel.fromJson(dynamic json) {
    id = json['id'] ?? 0;
    typeId = json['type_id'] ?? 0;
    total = json['total'] ?? 0.0;
    approved = json['approved'] ?? 0;
  }
}

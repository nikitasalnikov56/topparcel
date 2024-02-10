class FetchInvoiceResponse {
  late int status;
  late String description;
  late Invoice invoice;
  late String pdf;

  FetchInvoiceResponse({
    required this.status,
    required this.description,
    required this.invoice,
    required this.pdf,
  });

  factory FetchInvoiceResponse.fromJson(Map<String, dynamic> json) {
    return FetchInvoiceResponse(
      status: json['status'],
      description: json['description'],
      invoice: Invoice.fromJson(json['invoice']),
      pdf: json['pdf'],
    );
  }
}

class Invoice {
  late int id;
  late String dateCreated;
  late double total;
  late double vat;
  late int paid;
  late int typeId;
  late String number;
  late Payment payment;

  Invoice({
    required this.id,
    required this.dateCreated,
    required this.total,
    required this.vat,
    required this.paid,
    required this.typeId,
    required this.number,
    required this.payment,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      dateCreated: json['date_created'],
      total: json['total'],
      vat: json['vat'],
      paid: json['paid'],
      typeId: json['type_id'],
      number: json['number'],
      payment: Payment.fromJson(json['payment']),
    );
  }
}

class Payment {
  late int id;
  late int typeId;
  late double total;
  late int approved;

  Payment({
    required this.id,
    required this.typeId,
    required this.total,
    required this.approved,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      typeId: json['type_id'],
      total: json['total'],
      approved: json['approved'],
    );
  }
}

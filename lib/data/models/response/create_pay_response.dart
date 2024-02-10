// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreatePayResponse {
  late int status;
  late String description;
  late PaymentModel? payment;
  late String link;

  CreatePayResponse({
    required this.status,
    required this.description,
    required this.payment,
    required this.link,
  });

  CreatePayResponse.fromJson(dynamic json) {
    status = json['status'];
    description = json['description'];
    payment =
        json['payment'] != null ? PaymentModel.fromJson(json['payment']) : null;
    link = json['pay_link'];
  }
}

// {
//   "status": 200,
//   "description": "Payment details and pay link",
//   "payment": {
//     "id": "57334",
//     "type_id": 2,
//     "total": 100,
//     "approved": "0"
//   },
//   "pay_link": "https://checkout.stripe.com/c/pay/cs_live_a1XkDXwhgpyDnGdnsKZy5ku3JCUTOJefqmM0SxbQQnAGPLNipgcGOmEFbQ#fidkdWxOYHwnPyd1blppbHNgWjRoMGlna2o2Z1NQalVJd19cbl9PVWpXMicpJ2N3amhWYHdzYHcnP3F3cGApJ2lkfGpwcVF8dWAnPyd2bGtiaWBabHFgaCcpJ2BrZGdpYFVpZGZgbWppYWB3dic%2FcXdwYHgl"
// }

class PaymentModel {
  late String id;
  late String typeId;
  late int total;
  late String approved;

  PaymentModel({
    required this.id,
    required this.typeId,
    required this.total,
    required this.approved,
  });

  PaymentModel.fromJson(dynamic json) {
    id = (json['id'] ?? '').toString();
    typeId = (json['type_id'] ?? '').toString();
    total = json['total'] ?? '';
    approved = json['approved'] ?? '';
  }
}

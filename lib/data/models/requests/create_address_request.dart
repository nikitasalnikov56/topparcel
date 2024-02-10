// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreateAddressRequest {
  late int? id;
  late int countryId;
  late String token;
  late String region;
  late String city;
  late String addressLine1;
  late String addressLine2;
  late String zipcode;
  late String phone;
  late String lastname;
  late String firstname;
  late String email;
  late String company;
  late String vatNumber;

  CreateAddressRequest({
    this.id,
    required this.countryId,
    required this.token,
    required this.region,
    required this.city,
    required this.addressLine1,
    required this.addressLine2,
    required this.zipcode,
    required this.phone,
    required this.lastname,
    required this.firstname,
    required this.email,
    required this.company,
    required this.vatNumber,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.token;
    if (id != null) data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['city'] = this.city;
    data['region'] = this.region;
    data['address_line_1'] = this.addressLine1;
    data['address_line_2'] = this.addressLine2;
    data['zipcode'] = this.zipcode;
    data['phone'] = this.phone;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['vat_number'] = this.vatNumber;
    data['company'] = this.company;

    return data;
  }
}

// {
//   "password": "qM2oWUYvSXYtP4ItbC92yb0FW6cZsr0c",
//   "country_id": 5,
//   "region": "Suffolk",
//   "city": "Ipswich",
//   "address_line_1": "Bermuda road",
//   "address_line_2": "2",
//   "zipcode": "IP3 9RU",
//   "phone": "+441473711668",
//   "lastname": "Murphy",
//   "firstname": "Alex",
//   "email": "user@topparcel.com",
//   "company": "Topparcel Ltd",
//   "vat_number": "0000000000",
//   "id": 37379
// }
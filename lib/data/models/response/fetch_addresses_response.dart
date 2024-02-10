class UserAddressesResponse {
  late int status;
  late String description;
  late List<UserAddress> addresses;

  UserAddressesResponse({
    required this.status,
    required this.description,
    required this.addresses,
  });

  factory UserAddressesResponse.fromJson(Map<String, dynamic> json) {
    return UserAddressesResponse(
      status: json['status'],
      description: json['description'],
      addresses: (json['addresses'] as List)
          .map((i) => UserAddress.fromJson(i))
          .toList(),
    );
  }
}

class UserAddress {
  late String id;
  late String countryId;
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

  UserAddress({
    required this.id,
    required this.countryId,
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

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      id: json['id'] ?? '',
      countryId: json['country_id'] ?? '',
      region: json['region'] ?? '',
      city: json['city'] ?? '',
      addressLine1: json['address_line_1'] ?? '',
      addressLine2: json['address_line_2'] ?? '',
      zipcode: json['zipcode'] ?? '',
      phone: json['phone'] ?? '',
      lastname: json['lastname'] ?? '',
      firstname: json['firstname'] ?? '',
      email: json['email'] ?? '',
      company: json['company'] ?? '',
      vatNumber: json['vat_number'] ?? '',
    );
  }

  UserAddress.emptyModel() {
    id = '';
    countryId = '';
    region = '';
    city = '';
    addressLine1 = '';
    addressLine2 = '';
    zipcode = '';
    phone = '';
    lastname = '';
    firstname = '';
    email = '';
    company = '';
    vatNumber = '';
  }
}

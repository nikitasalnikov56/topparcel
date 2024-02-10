class UpdateUserRequest {
  late String email;
  late String password;
  late String? firstname;
  late String? lastname;
  late String? phone;
  late int? countryId;
  late String? addressLine1;
  late String? addressLine2;
  late String? city;
  late String? county;
  late String? postcode;

  UpdateUserRequest({
    required this.email,
    required this.password,
    this.firstname,
    this.lastname,
    this.phone,
    this.countryId,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.county,
    this.postcode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['phone'] = this.phone;
    data['country_id'] = this.countryId;
    data['address_line_1'] = this.addressLine1;
    data['address_line_2'] = this.addressLine2;
    data['city'] = this.city;
    data['county'] = this.county;
    data['postcode'] = this.postcode;

    return data;
  }

  UpdateUserRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    firstname = json.containsKey('firstname') ? json['firstname'] : null;
    lastname = json.containsKey('lastname') ? json['lastname'] : null;
    phone = json.containsKey('phone') ? json['phone'] : null;
    countryId = json.containsKey('country_id') ? json['country_id'] : null;
    addressLine1 =
        json.containsKey('address_line_1') ? json['address_line_1'] : null;
    addressLine2 =
        json.containsKey('address_line_2') ? json['address_line_2'] : null;
    city = json.containsKey('city') ? json['city'] : null;
    county = json.containsKey('county') ? json['county'] : null;
    postcode = json.containsKey('postcode') ? json['postcode'] : null;
  }
}

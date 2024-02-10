// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegistrationRequest {
  late String email;
  late String password;
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late int countryId;
  late String addressLine1;
  late String addressLine2;
  late String city;
  late String country;
  late String postcode;
  late int sms;
  late int subscribe;
  late String tine;

  RegistrationRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.countryId,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.country,
    required this.postcode,
    required this.sms,
    required this.subscribe,
    required this.tine,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['email'] = email;
    map['password'] = password;
    map['firstname'] = firstName;
    map['lastname'] = lastName;
    map['phone'] = phoneNumber;
    map['country_id'] = countryId;
    map['address_line_1'] = addressLine1;
    map['address_line_2'] = addressLine2;
    map['city'] = city;
    map['country'] = country;
    map['postcode'] = postcode;
    map['sms'] = sms;
    map['subscribe'] = subscribe;
    map['tine'] = tine;

    return map;
  }
}

class UserDetailsResponse {
  late int status;
  late String description;
  late UserModel user;

  UserDetailsResponse({
    required this.status,
    required this.description,
    required this.user,
  });

  UserDetailsResponse.fromJson(dynamic json) {
    status = json['status'];
    description = json['description'];
    user = UserModel.fromJson(json['user']);
  }
}

class UserModel {
  late String id;
  late String token;
  late String email;
  late String firstname;
  late String lastname;
  late String phone;
  late String countryId;
  late String addressLine1;
  late String addressLine2;
  late String city;
  late String county;
  late String postcode;
  late String sms;
  late String subscribed;
  late String tin;
  late int balance;

  UserModel({
    required this.id,
    required this.token,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.countryId,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.county,
    required this.postcode,
    required this.sms,
    required this.subscribed,
    required this.tin,
    required this.balance,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    token = json['token'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    countryId = json['country_id'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    city = json['city'] ?? '';
    county = json['county'] ?? '';
    postcode = json['postcode'] ?? '';
    sms = json['sms'] ?? '';
    subscribed = json['subscribed'] ?? '';
    tin = json['tin'] ?? '';
    balance = json['balance'] ?? 0;
  }

  UserModel.emptyModel() {
    id = '';
    token = '';
    email = '';
    firstname = '';
    lastname = '';
    phone = '';
    countryId = '';
    addressLine1 = '';
    addressLine2 = '';
    city = '';
    county = '';
    postcode = '';
    sms = '';
    subscribed = '';
    tin = '';
    balance = 0;
  }
}

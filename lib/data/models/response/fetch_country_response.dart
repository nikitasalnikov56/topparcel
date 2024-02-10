class FetchCountryResponse {
  late int status;
  late List<Country> countriesList;

  FetchCountryResponse({
    required this.status,
    required this.countriesList,
  });

  FetchCountryResponse.fromJson(dynamic json) {
    status = json['status'];
    if (status == 200) {
      countriesList = (json['countries'] as List<dynamic>)
          .map((e) => Country.fromJson(e))
          .toList();
    }
    print('');
  }
}

class Country {
  late String id;
  late String name;
  late String code;
  late String code2;
  late bool deliverable;
  late bool sendable;

  Country({
    required this.id,
    required this.name,
    required this.code,
    required this.code2,
    required this.deliverable,
    required this.sendable,
  });

  Country.fromJson(dynamic json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    code = json['code'] ?? '';
    code2 = json['code2'] ?? '';
    deliverable = json['deliverable'] ?? true;
    sendable = json['sendable'] ?? true;
  }

  static Country emptyModel({String? id, String? name}) {
    return Country(
      id: id ?? '',
      name: name ?? '',
      code: '',
      code2: '',
      deliverable: true,
      sendable: true,
    );
  }
}

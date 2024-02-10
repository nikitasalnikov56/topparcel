class CreaterateResponse {
  late List<ParcelResponse> parcelsList;

  CreaterateResponse({
    required this.parcelsList,
  });

  CreaterateResponse.fromJson(dynamic json) {
    parcelsList = (json['parcels'] as List<dynamic>)
        .map((e) => ParcelResponse.fromJson(e))
        .toList();
  }
}

class ParcelResponse {
  late String currency;
  late AddressResponse collection;
  late AddressResponse address;
  late DateTime dateCollection;
  late int width;
  late int height;
  late double weight;
  late int length;
  late int serviceId;
  late int packageId;
  late double price;
  late int vat;
  late String timeTransit;
  late List<Courier> couriers;

  ParcelResponse({
    required this.currency,
    required this.collection,
    required this.address,
    required this.width,
    required this.height,
    required this.weight,
    required this.length,
    required this.serviceId,
    required this.packageId,
    required this.couriers,
    required this.price,
    required this.timeTransit,
    required this.dateCollection,
    required this.vat,
  });

  ParcelResponse.fromJson(dynamic json) {
    currency = json['currency'];
    collection = AddressResponse.fromJson(json['collection']);
    address = AddressResponse.fromJson(json['address']);
    width = json['shipments'][0]['width'];
    height = json['shipments'][0]['height'];
    weight = json['shipments'][0]['weight'] is int
        ? (json['shipments'][0]['weight'] as int).toDouble()
        : json['shipments'][0]['weight'];
    length = json['shipments'][0]['length'];
    serviceId = json['service_id'] ?? 1;
    packageId = json['package_id'];
    couriers = [];
    //переделать
    // for (var key in json['couriers'].keys) {
    //   couriers.add(_parseCourier(json['couriers'][key], key));
    // }
    if (json.containsKey('couriers') && json['couriers'] is List<dynamic>) {
      for (var courierJson in json['couriers']) {
        couriers.add(_parseCourier(courierJson));
      }
    }
    price = json['price'] ?? 0.0;
    vat = json['vat'] ?? 0;
    timeTransit = json['time_transit'] ?? '';
    dateCollection = json['date_collection'] != null
        ? DateTime.parse(json['date_collection'])
        : DateTime.now();
  }

  Courier _parseCourier(Map<String, dynamic> courierJson) {
    final nameCompany = courierJson['name'];
    final countDays = '${courierJson['time']}';

    final cost = courierJson['rate'];

    return Courier(
      serviceId: courierJson['id'] ?? '',
      companyName: nameCompany,
      countDays: countDays,
      cost: cost.toString(),
    );
  }
}

class Courier {
  late String serviceId;
  late String companyName;
  late String countDays;
  late String cost;

  Courier({
    required this.serviceId,
    required this.companyName,
    required this.countDays,
    required this.cost,
  });

  static Courier emptyModel() {
    return Courier(serviceId: '', companyName: '', cost: '', countDays: '');
  }
}

class AddressResponse {
  late int countryId;
  late String city;
  late String zipcode;

  AddressResponse({
    required this.countryId,
    required this.city,
    required this.zipcode,
  });

  AddressResponse.fromJson(dynamic json) {
    countryId = json['country_id'];
    city = json['city'];
    zipcode = json['zipcode'];
  }
}

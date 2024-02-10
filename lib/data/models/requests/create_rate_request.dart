// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreaterateRequest {
  late String email;
  late String token;
  late List<Parcel> parcelsList;

  CreaterateRequest({
    required this.email,
    required this.token,
    required this.parcelsList,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['email'] = email;
    map['password'] = token;
    map['parcels'] = parcelsList.map((e) => e.toJson()).toList();
    return map;
  }
}

class Parcel {
  late String currency;
  late List<Shipment> shipments;
  late Address collection;
  late Address address;
  late int? serviceId;
  late int packageId;

  Parcel({
    required this.currency,
    required this.collection,
    required this.address,
    required this.shipments,
    this.serviceId,
    required this.packageId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['currency'] = currency;
    map['shipments'] = shipments.map((e) => e.toJson()).toList();
    map['collection'] = collection.toJson();
    map['address'] = address.toJson();
    if (serviceId != null) map['service_id'] = serviceId;
    map['package_id'] = packageId;
    return map;
  }
}

class Shipment {
  late double width;
  late double height;
  late double weight;
  late int length;

  Shipment({
    required this.width,
    required this.height,
    required this.weight,
    required this.length,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['width'] = width;
    map['height'] = height;
    map['length'] = length;
    map['weight'] = weight;
    return map;
  }
}

class Address {
  late int countryId;
  late String city;
  late String zipcode;

  Address({
    required this.countryId,
    required this.city,
    required this.zipcode,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['country_id'] = countryId;
    map['city'] = city;
    map['zipcode'] = zipcode;
    return map;
  }
}

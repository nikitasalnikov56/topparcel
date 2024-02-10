import 'create_rate_request.dart';

class CreateParcelRequest {
  late String email;
  late String token;
  late ParcelsRequest parcels;

  CreateParcelRequest({
    required this.email,
    required this.token,
    required this.parcels,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['email'] = email;
    map['password'] = token;
    map['parcels'] = [parcels.toJson()];
    return map;
  }
}

class ParcelsRequest {
  late String currency;
  late AddressModel collection;
  late AddressModel address;
  late List<ItemModel> itemsList;
  late List<Shipment> shipments;
  late int serviceId;
  late String apiParcelId;
  late String contentsId;
  late String reference;
  late int insurance;
  late String iossNumber;
  late int packageId;

  ParcelsRequest({
    required this.currency,
    required this.collection,
    required this.address,
    required this.itemsList,
    required this.shipments,
    required this.serviceId,
    required this.apiParcelId,
    required this.contentsId,
    required this.reference,
    required this.insurance,
    required this.iossNumber,
    required this.packageId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['currency'] = currency;
    map['collection'] = collection;
    map['address'] = address;
    map['items'] = itemsList;
    map['shipments'] = shipments.map((e) => e.toJson()).toList();
    map['service_id'] = serviceId;
    map['api_parcel_id'] = apiParcelId;
    // map['contents_id'] = contentsId;
    // map['reference'] = reference;
    map['insurance'] = insurance;
    // map['ioss_number'] = iossNumber;
    map['package_id'] = packageId;
    return map;
  }
}

class AddressModel {
  late int countryId;
  late String region;
  late String city;
  late String addressLine1;
  late String addressLine2;
  late String zipcode;
  late String phone;
  late String lastName;
  late String firstName;
  late String email;
  late String company;
  late int vatNumber;

  AddressModel({
    required this.countryId,
    required this.region,
    required this.city,
    required this.addressLine1,
    required this.addressLine2,
    required this.zipcode,
    required this.phone,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.company,
    required this.vatNumber,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['country_id'] = countryId;
    map['region'] = region;
    map['city'] = city;
    map['address_line_1'] = addressLine1;
    map['address_line_2'] = addressLine2;
    map['zipcode'] = zipcode;
    map['phone'] = phone;
    map['lastname'] = lastName;
    map['firstname'] = firstName;
    map['email'] = email;
    map['company'] = company;
    map['vat_number'] = vatNumber;
    return map;
  }
}

class ItemModel {
  late String id;
  late String description;
  late String quantity;
  late String cost;
  late String sku;
  late String url;

  ItemModel({
    required this.id,
    required this.description,
    required this.quantity,
    required this.cost,
    required this.sku,
    required this.url,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['hscode_id'] = id;
    map['description'] = description;
    map['qty'] = quantity;
    map['cost'] = cost;
    map['sku'] = sku;
    map['url'] = url;
    return map;
  }
}

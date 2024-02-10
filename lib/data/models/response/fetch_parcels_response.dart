import 'package:topparcel/data/models/app_model/invoice_model.dart';

class FetchParcelsResponse {
  late List<ParcelModel> parcelsList;

  FetchParcelsResponse({
    required this.parcelsList,
  });

  FetchParcelsResponse.fromJson(dynamic json) {
    parcelsList = (json['parcels'] as List<dynamic>)
        .map((e) => ParcelModel.fromJson(e))
        .toList();
  }
}

class ParcelModel {
  late String id;
  late DateTime dateCreate;
  late String statusId;
  late String status;
  late String width;
  late String height;
  late String weight;
  late String length;
  late String serviceId;
  late String track;
  late String warehouseId;
  late String cost;
  late AddressModelResponse collection;
  late AddressModelResponse address;
  late List<Items> items;
  late List<InvoiceModel> invoice;

  ParcelModel({
    required this.id,
    required this.dateCreate,
    required this.statusId,
    required this.status,
    required this.width,
    required this.height,
    required this.weight,
    required this.length,
    required this.serviceId,
    required this.track,
    required this.warehouseId,
    required this.collection,
    required this.address,
    required this.cost,
    required this.invoice,
    //ne ponyal
    required this.items,
  });

  ParcelModel.fromJson(dynamic json) {
    id = json['id'];
    dateCreate = DateTime.parse(json['date_created']);
    statusId = json['status_id'] ?? '';
    status = json['status'] ?? '';
    width = json['width'] ?? '';
    height = json['height'] ?? '';
    weight = json['weight'] ?? '';
    length = json['length'] ?? '';
    serviceId = json['service_id'] ?? '';
    track = json['track'] ?? '';
    warehouseId = json['warehouse_id'] ?? '';
    collection = json['collection'] != null
        ? AddressModelResponse.fromJson(json['collection'])
        : AddressModelResponse.emptyModel();
    address = json['address'] != null
        ? AddressModelResponse.fromJson(json['address'])
        : AddressModelResponse.emptyModel();
    items = json['items'] != null
        ? (json['items'] as List<dynamic>)
            .map((e) => Items.fromJson(e))
            .toList()
        : [];
    cost = (json['cost'] ?? '').toString();
    invoice = json['invoices'] != null
        ? (json['invoices'] as List<dynamic>)
            .map((e) => InvoiceModel.fromJson(e))
            .toList()
        : [];
  }
}

class AddressModelResponse {
  late String countryId;
  late String city;
  late String addressline1;
  late String? addressline2;
  late String zipcode;
  late String phone;
  late String lastName;
  late String firstName;
  late String email;
  late String company;
  late String vatNumber;

  AddressModelResponse({
    required this.countryId,
    required this.city,
    required this.addressline1,
    required this.zipcode,
    required this.phone,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.company,
    required this.vatNumber,
    this.addressline2,
  });

  AddressModelResponse.fromJson(dynamic json) {
    countryId = json['country_id'] ?? '';
    city = json['city'] ?? '';
    addressline1 = json['address_line_1'] ?? '';
    addressline2 = json['address_line_2'] ?? '';
    zipcode = json['zipcode'] ?? '';
    phone = json['phone'] ?? '';
    lastName = json['lastname'] ?? '';
    firstName = json['firstname'] ?? '';
    email = json['email'] ?? '';
    company = json['company'] ?? '';
    vatNumber = json['vat_number'] ?? '';
  }

  static AddressModelResponse emptyModel() {
    return AddressModelResponse(
      countryId: '',
      city: '',
      addressline1: '',
      zipcode: '',
      phone: '',
      lastName: '',
      firstName: '',
      email: '',
      company: '',
      vatNumber: '',
    );
  }
}

class Items {
  late String id;
  late String description;
  late String qty;
  late double cost;

  Items({
    required this.id,
    required this.description,
    required this.qty,
    required this.cost,
  });

  Items.fromJson(dynamic json) {
    id = json['hscode_id'];
    description = json['description'];
    qty = json['qty'];
    cost = json['cost'];
  }
}

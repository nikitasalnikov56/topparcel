// ignore_for_file: public_member_api_docs, sort_constructors_first
class TrackingNumberResponse {
  late int status;
  late List<Event> events;

  TrackingNumberResponse({
    required this.status,
    required this.events,
  });

  TrackingNumberResponse.fromJson(dynamic json) {
    status = json['status'];
    if (status == 200) {
      events = (json['events'] as List<dynamic>)
          .map((e) => Event.fromJson(e))
          .toList();
    } else {
      TrackingNumberResponse(
        status: 200,
        events: [
          Event(
            dateCreate: DateTime.now(),
            countryCode: 'GB',
            address: 'Bury St Edmunds',
            status: 'Pickup Scan',
            statusId: '250',
          ),
          Event(
            dateCreate: DateTime.now(),
            countryCode: 'GB',
            address: 'SOUTH OCKENDON',
            status: 'Delivered',
            statusId: '410',
          ),
        ],
      );
    }
  }
}

class Event {
  late DateTime dateCreate;
  late String countryCode;
  late String address;
  late String status;
  late String statusId;

  Event({
    required this.dateCreate,
    required this.countryCode,
    required this.address,
    required this.status,
    required this.statusId,
  });

  Event.fromJson(dynamic json) {
    dateCreate = json['date_created'] != null
        ? DateTime.parse(json['date_created'])
        : DateTime.now();
    countryCode = json['country_code'] ?? '';
    address = json['address'] ?? '-';
    status = json['status'] ?? '';
    statusId = (json['status_id'] ?? 0).toString();
  }
}

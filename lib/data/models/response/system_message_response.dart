class SystemMessage {
  late int id;
  late DateTime date;
  late int? priority;
  late String detailHtml;

  SystemMessage({
    required this.id,
    required this.date,
    required this.detailHtml,
    required this.priority,
  });

  static SystemMessage empty() {
    return SystemMessage(
        id: 1, date: DateTime.now(), detailHtml: '', priority: 0);
  }

  SystemMessage.fromJson(dynamic json) {
    detailHtml = json['detailHtml'];
    priority = json['priority'];
    id = json['messageId'];
    try {
      date = DateTime.parse(json['dateFrom']);
    } catch (e) {
      date = DateTime.now();
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['detailHtml'] = detailHtml;
    map['priority'] = priority;
    map['dateFrom'] = date.toString();
    map['messageId'] = id;
    return map;
  }
}

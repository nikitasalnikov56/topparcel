class CreateHscodeResponse {
  dynamic status;
  String? description;
  List<Hscodes>? hscodes;

  CreateHscodeResponse({this.status, this.description, this.hscodes});

  CreateHscodeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    description = json['description'];
    if (json['hscodes'] != null) {
      hscodes = <Hscodes>[];
      json['hscodes'].forEach((v) {
        hscodes!.add(Hscodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['description'] = description;
    if (hscodes != null) {
      data['hscodes'] = hscodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hscodes {
  dynamic id;
  String? code;
  String? name;

  Hscodes({this.id, this.code, this.name});

  Hscodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}

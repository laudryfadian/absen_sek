class Cek {
  Cek({
    required this.status,
    required this.statusCode,
    required this.timestamp,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final int statusCode;
  late final String timestamp;
  late final String message;
  late final Data data;

  Cek.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['statusCode'] = statusCode;
    _data['timestamp'] = timestamp;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.masuk,
    required this.pulang,
  });
  late final bool masuk;
  late final bool pulang;

  Data.fromJson(Map<String, dynamic> json) {
    masuk = json['masuk'];
    pulang = json['pulang'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['masuk'] = masuk;
    _data['pulang'] = pulang;
    return _data;
  }
}

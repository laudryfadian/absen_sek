class Cek {
  Cek({
    required this.status,
    required this.statusCode,
    required this.timestamp,
    required this.data,
  });
  late final bool status;
  late final int statusCode;
  late final String timestamp;
  late final Data data;

  Cek.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['statusCode'] = statusCode;
    _data['timestamp'] = timestamp;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.message,
    required this.route,
  });
  late final String message;
  late final String route;

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    route = json['route'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['route'] = route;
    return _data;
  }
}

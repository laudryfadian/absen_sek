class AbsenToday {
  AbsenToday({
    required this.status,
    required this.statusCode,
    required this.timestamp,
    required this.data,
  });
  late final bool status;
  late final int statusCode;
  late final String timestamp;
  late final List<Data> data;

  AbsenToday.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['statusCode'] = statusCode;
    _data['timestamp'] = timestamp;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.idUser,
    required this.status,
    required this.time,
    required this.date,
    required this.image,
    required this.lat,
    required this.long,
    required this.approve,
  });
  late final String id;
  late final IdUser idUser;
  late final String status;
  late final String time;
  late final String date;
  late final String image;
  late final String lat;
  late final String long;
  late final bool approve;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = IdUser.fromJson(json['idUser']);
    status = json['status'];
    time = json['time'];
    date = json['date'];
    image = json['image'];
    lat = json['lat'];
    long = json['long'];
    approve = json['approve'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['idUser'] = idUser.toJson();
    _data['status'] = status;
    _data['time'] = time;
    _data['date'] = date;
    _data['image'] = image;
    _data['lat'] = lat;
    _data['lat'] = long;
    _data['approve'] = approve;
    return _data;
  }
}

class IdUser {
  IdUser({
    required this.id,
    required this.nama,
  });
  late final String id;
  late final String nama;

  IdUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = nama;
    return _data;
  }
}

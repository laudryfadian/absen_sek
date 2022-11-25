class AbsenToday {
  AbsenToday({
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
  late final List<Data> data;

  AbsenToday.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    message = json['message'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['statusCode'] = statusCode;
    _data['timestamp'] = timestamp;
    _data['message'] = message;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.idUser,
    required this.ket,
    required this.jam,
    required this.tanggal,
    required this.foto,
    required this.lat,
    required this.long,
    required this.approve,
  });
  late final String id;
  late final IdUser idUser;
  late final String ket;
  late final String jam;
  late final String tanggal;
  late final String foto;
  late final String lat;
  late final String long;
  late final String approve;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    idUser = IdUser.fromJson(json['idUser']);
    ket = json['ket'];
    jam = json['jam'];
    tanggal = json['tanggal'];
    foto = json['foto'];
    lat = json['lat'];
    long = json['long'];
    approve = json['approve'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['idUser'] = idUser.toJson();
    _data['ket'] = ket;
    _data['jam'] = jam;
    _data['tanggal'] = tanggal;
    _data['foto'] = foto;
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
    id = json['_id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['nama'] = nama;
    return _data;
  }
}

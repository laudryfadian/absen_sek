import 'dart:convert';

import 'package:absen_sek/helpers/basic_auth.dart';
import 'package:absen_sek/models/absen_today.dart';
import 'package:absen_sek/network/network.dart';
import 'package:http/http.dart' as http;

class AbsenTodayService {
  Future<List<Data>> getTodayAbsen() async {
    List<Data> history = [];

    var basic = await BasicAuth().getBasic();

    var response = await http.get(Uri.parse(BaseURL.domain + "/absen/hariini"),
        headers: {"authorization": basic});

    print(response.body);

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body)['data'];
      history = result.map((i) => Data.fromJson(i)).toList();
    } else {
      return history;
    }
    return history;
  }
}

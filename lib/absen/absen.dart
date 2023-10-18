import 'dart:convert';

import 'package:absen_sek/helpers/basic_auth.dart';
import 'package:absen_sek/models/absen_today.dart';
import 'package:absen_sek/network/network.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AbsenTodayService {
  Future<List<Data>> getTodayAbsen() async {
    List<Data> history = [];
    final prefs = await SharedPreferences.getInstance();
    var idCompany = prefs.getString('idCompany');

    var response = await http.get(
      Uri.parse(BaseURL.domain + "/absen/today/" + idCompany.toString()),
    );

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body)['data'];
      history = result.map((i) => Data.fromJson(i)).toList();
    } else {
      return history;
    }
    return history;
  }
}

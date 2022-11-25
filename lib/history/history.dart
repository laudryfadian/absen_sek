import 'dart:convert';

import 'package:absen_sek/helpers/basic_auth.dart';
import 'package:absen_sek/models/history.dart';
import 'package:absen_sek/network/network.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  Future<List<Data>> getHistoryUserAbsen() async {
    List<Data> history = [];

    final prefs = await SharedPreferences.getInstance();
    var idUser = prefs.getString('idUser');

    var basic = await BasicAuth().getBasic();

    var response = await http.get(
        Uri.parse(BaseURL.domain + "/absen/" + idUser.toString()),
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

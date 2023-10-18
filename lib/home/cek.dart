import 'dart:convert';

import 'package:absen_sek/helpers/basic_auth.dart';
import 'package:absen_sek/models/cek.dart';
import 'package:absen_sek/network/network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ServiceCek {
  Future<Cek> cekAbsen() async {
    // var basic = await BasicAuth().getBasic();

    // print(basic);
    final prefs = await SharedPreferences.getInstance();
    var idUser = prefs.getString("idUser");

    final response = await http
        .get(Uri.parse("${BaseURL.domain}/absen/cek/${idUser!}"), headers: {
      // "authorization": basic,
    });

    print(response.body);

    if (response.statusCode == 200) {
      return Cek.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}

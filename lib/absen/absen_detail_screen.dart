import 'dart:convert';

import 'package:absen_sek/constant.dart';
import 'package:absen_sek/helpers/alert.dart';
import 'package:absen_sek/helpers/basic_auth.dart';
import 'package:absen_sek/models/absen_today.dart';
import 'package:absen_sek/network/network.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AbsenDetailScreen extends StatefulWidget {
  final Data data;
  const AbsenDetailScreen({super.key, required this.data});

  @override
  State<AbsenDetailScreen> createState() => _AbsenDetailScreenState();
}

class _AbsenDetailScreenState extends State<AbsenDetailScreen> {
  final List<String> items = [
    'approve',
    'pending',
    'not approve',
  ];
  String? selectedValue;
  bool superUser = false;

  @override
  void initState() {
    selectedValue = widget.data.approve;
    cekSuperUser();
    super.initState();
  }

  cekSuperUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      superUser = prefs.getBool('superUser')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.data.idUser.nama),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.data.tanggal,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    widget.data.jam,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Image.network(widget.data.foto),
              ),
              SizedBox(height: 15),
              superUser
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            approve();
                          },
                          child: const Text(
                            "Simpan",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: Text(
                                'Pilih Approve',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                });
                              },
                              // buttonHeight: 50,
                              buttonWidth: 140,
                              itemHeight: 40,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(height: 15),
              Text(
                "${widget.data.lat}, ${widget.data.long}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: OpenStreetMapSearchAndPick(
                  center: LatLong(double.parse(widget.data.lat),
                      double.parse(widget.data.long)),
                  onPicked: (PickedData pickedData) {},
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Google Maps",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  approve() async {
    final body =
        jsonEncode({"idAbsen": widget.data.id, "approve": selectedValue});

    var basic = await BasicAuth().getBasic();

    final response = await http.put(
        Uri.parse(BaseURL.domain + "/absen/approve"),
        headers: {"Content-Type": "application/json", "authorization": basic},
        body: body);

    var msg = jsonDecode(response.body)['message'];
    print(response.body);

    if (response.statusCode == 200) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

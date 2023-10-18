import 'package:absen_sek/absen/absen.dart';
import 'package:absen_sek/absen/absen_detail_screen.dart';
import 'package:absen_sek/constant.dart';
import 'package:absen_sek/models/absen_today.dart';
import 'package:flutter/material.dart';

class AbsenScreen extends StatefulWidget {
  const AbsenScreen({super.key});

  @override
  State<AbsenScreen> createState() => _AbsenScreenState();
}

class _AbsenScreenState extends State<AbsenScreen> {
  List<Data> absen = [];
  late AbsenTodayService service;

  @override
  void initState() {
    service = AbsenTodayService();
    fetch();
    super.initState();
  }

  fetch() async {
    absen = await service.getTodayAbsen();
    setState(() {
      absen = absen;
    });
  }

  Future<Null> refresh() async {
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constant.backgroundColor,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: refresh,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 37),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 43),
                  Text(
                    "Absen Hari ini",
                    style: TextStyle(fontSize: 24),
                  ),
                  // Text(
                  //   "Selasa, 15 Mei 2022",
                  //   style: TextStyle(fontSize: 16),
                  // ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: absen.length,
                      itemBuilder: (context, index) {
                        var data = absen[index];
                        return InkWell(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data.idUser.nama,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          data.time + " ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 21),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          child: data.approve
                                              ? Image.asset(
                                                  "assets/images/check.png",
                                                )
                                              : Image.asset(
                                                  "assets/images/cancel.png",
                                                ),
                                        ),
                                        // Text(
                                        //   data.status,
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 24),
                                        // ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AbsenDetailScreen(
                                  data: data,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

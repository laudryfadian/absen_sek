import 'package:absen_sek/absen/absen_detail_screen.dart';
import 'package:absen_sek/constant.dart';
import 'package:flutter/material.dart';

class AbsenScreen extends StatefulWidget {
  const AbsenScreen({super.key});

  @override
  State<AbsenScreen> createState() => _AbsenScreenState();
}

class _AbsenScreenState extends State<AbsenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constant.backgroundColor,
        body: SafeArea(
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
                Text(
                  "Selasa, 15 Mei 2022",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      InkWell(
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
                                    "Roronoa",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          height: 30,
                                          width: 30,
                                          child: Image.asset(
                                            "assets/images/progress.gif",
                                          )),
                                      Text(
                                        " Masuk",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AbsenDetailScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

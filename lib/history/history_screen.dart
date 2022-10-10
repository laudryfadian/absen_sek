import 'package:absen_sek/constant.dart';
import 'package:absen_sek/history/history_detail_screen.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
                  "History",
                  style: TextStyle(fontSize: 24),
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
                            child: ListTile(
                              title: Text(
                                "Selasa, 15 Mei 2022",
                                style: TextStyle(fontSize: 17),
                              ),
                              subtitle: Text(
                                "Masuk",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              trailing:
                                  Image.asset("assets/images/progress.gif"),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HistoryDetailScreen()),
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

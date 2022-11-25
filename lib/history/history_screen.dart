import 'package:absen_sek/constant.dart';
import 'package:absen_sek/history/history.dart';
import 'package:absen_sek/history/history_detail_screen.dart';
import 'package:absen_sek/models/history.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Data> history = [];
  late HistoryService service;

  @override
  void initState() {
    service = HistoryService();
    fetch();
    super.initState();
  }

  fetch() async {
    history = await service.getHistoryUserAbsen();
    setState(() {
      history = history;
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
                    "History",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        var data = history[index];
                        return InkWell(
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
                                  data.tanggal,
                                  style: TextStyle(fontSize: 17),
                                ),
                                subtitle: Text(
                                  data.ket,
                                  style: TextStyle(
                                      color: data.ket == "masuk"
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                trailing: data.approve == "pending"
                                    ? Image.asset("assets/images/progress.gif")
                                    : data.approve == "approve"
                                        ? Image.asset("assets/images/check.png")
                                        : Image.asset(
                                            "assets/images/cancel.png"),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HistoryDetailScreen(
                                        data: data,
                                      )),
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

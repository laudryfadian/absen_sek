import 'package:absen_sek/constant.dart';
import 'package:flutter/material.dart';

class HistoryDetailScreen extends StatefulWidget {
  const HistoryDetailScreen({super.key});

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.backgroundColor,
      appBar: AppBar(
        title: Text("Detail History"),
      ),
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }
}

import 'package:absen_sek/constant.dart';
import 'package:flutter/material.dart';

class AbsenDetailScreen extends StatefulWidget {
  const AbsenDetailScreen({super.key});

  @override
  State<AbsenDetailScreen> createState() => _AbsenDetailScreenState();
}

class _AbsenDetailScreenState extends State<AbsenDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.backgroundColor,
      appBar: AppBar(
        title: Text("Detail Absen"),
      ),
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }
}

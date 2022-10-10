import 'package:absen_sek/constant.dart';
import 'package:flutter/material.dart';

class AkunScreen extends StatefulWidget {
  const AkunScreen({super.key});

  @override
  State<AkunScreen> createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 37),
            child: Column(
              children: [
                Text(
                  "Profil",
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

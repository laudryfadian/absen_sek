import 'package:absen_sek/bottomnav.dart';
import 'package:absen_sek/constant.dart';
import 'package:absen_sek/home/home_screen.dart';
import 'package:absen_sek/login/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primarySwatch: Constant.yellowPrim, fontFamily: 'Outfit'),
      home: LoginScreen(),
    );
  }
}

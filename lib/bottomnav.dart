import 'package:absen_sek/absen/absen_screen.dart';
import 'package:absen_sek/akun/akun_screen.dart';
import 'package:absen_sek/constant.dart';
import 'package:absen_sek/history/history_screen.dart';
import 'package:absen_sek/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<Widget> screen() {
    return [HomeScreen(), HistoryScreen(), AbsenScreen(), AkunScreen()];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: "Home",
          activeColorPrimary: Constant.yellowPrim,
          activeColorSecondary: Colors.black,
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.history),
          title: "History",
          activeColorPrimary: Constant.yellowPrim,
          activeColorSecondary: Colors.black,
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.square_list),
          title: "Absen",
          activeColorPrimary: Constant.yellowPrim,
          activeColorSecondary: Colors.black,
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.person_fill),
          title: "Akun",
          activeColorPrimary: Constant.yellowPrim,
          activeColorSecondary: Colors.black,
          inactiveColorPrimary: Colors.black)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: screen(),
      items: navBarItems(),
      navBarStyle: NavBarStyle.style10,
    );
  }
}

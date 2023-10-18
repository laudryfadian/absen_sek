import 'package:absen_sek/constant.dart';
import 'package:absen_sek/login/login_screen.dart';
import 'package:absen_sek/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AkunScreen extends StatefulWidget {
  const AkunScreen({super.key});

  @override
  State<AkunScreen> createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  String? nama, email, nohp, posisi, imageProfil;
  int? gaji;
  bool superUser = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      nama = prefs.getString('nama');
      email = prefs.getString('email');
      nohp = prefs.getString('nohp');
      posisi = prefs.getString('posisi');
      gaji = prefs.getInt('gaji');
      superUser = prefs.getBool('superUser')!;
      imageProfil = prefs.getString('image');
    });
  }

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profil",
                      style: TextStyle(fontSize: 24),
                    ),
                    superUser
                        ? InkWell(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Constant.yellowPrim,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(Icons.person_add_alt_rounded),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()),
                              );
                            },
                          )
                        : Container()
                  ],
                ),
                SizedBox(height: 15),
                Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Constant.yellowPrim, width: 4),
                        shape: BoxShape.circle,
                        image: imageProfil != null
                            ? DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(imageProfil!))
                            : DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/xoro.png")))),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      nama.toString(),
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.mail_outlined,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      email.toString(),
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      nohp.toString(),
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.source_outlined,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      posisi.toString(),
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.monetization_on_outlined,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      gaji.toString(),
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      logout();
                    },
                    child: Text(
                      "Keluar",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    Navigator.pop(context);
    PersistentNavBarNavigator.pushNewScreen(context,
        screen: LoginScreen(), withNavBar: false);
  }
}

import 'dart:convert';

import 'package:absen_sek/bottomnav.dart';
import 'package:absen_sek/helpers/alert.dart';

import 'package:absen_sek/network/network.dart';
import 'package:absen_sek/register/face_registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool loading = false;

  bool securePassword = true;

  @override
  void initState() {
    cekUser();
    super.initState();
  }

  cekUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUser = pref.getString("idUser");

    if (idUser != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNav()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text("Login",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(CupertinoIcons.person_fill)
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text("Selamat Datang",
                      style: TextStyle(fontSize: 14)),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Absen",
                      style:
                          TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " Sek",
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFC600)),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  obscureText: securePassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: securePassword
                            ? Icon(CupertinoIcons.eye_slash)
                            : Icon(Icons.remove_red_eye),
                        onPressed: () {
                          if (securePassword) {
                            setState(() {
                              securePassword = false;
                            });
                          } else {
                            setState(() {
                              securePassword = true;
                            });
                          }
                        },
                      )),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: loading
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : const Text(
                            "Login",
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

  void login() async {
    setState(() {
      loading = true;
    });

    final prefs = await SharedPreferences.getInstance();

    var body = jsonEncode(
        {"email": emailController.text, "password": passwordController.text});

    try {
      var response = await http.post(Uri.parse(BaseURL.domain + "/auth"),
          headers: {"Content-Type": "application/json"}, body: body);

      if (response.statusCode == 200) {
        var verify = jsonDecode(response.body)['data']['verify'];

        if (!verify) {
          ShowAlert.alertFailedWithNavigatePush(
              context,
              "Verifikasi Wajahmu Terlebih Dahulu",
              FaceRegistrationScreen(
                email: emailController.text,
                password: passwordController.text,
              ));
        } else {
          var idUser = jsonDecode(response.body)['data']['id'];
          var email = jsonDecode(response.body)['data']['email'];
          var nama = jsonDecode(response.body)['data']['name'];
          var nohp = jsonDecode(response.body)['data']['phone'];
          var idCategory = jsonDecode(response.body)['data']['idCategory'];
          var category = jsonDecode(response.body)['data']['category'];
          var idCompany = jsonDecode(response.body)['data']['idCompany'];
          var company = jsonDecode(response.body)['data']['company'];
          var image = jsonDecode(response.body)['data']['image'];
          var isAbsen = jsonDecode(response.body)['data']['isAbsen'];
          var job = jsonDecode(response.body)['data']['job'];
          var jobType = jsonDecode(response.body)['data']['jobType'];
          var superUser = jsonDecode(response.body)['data']['superUser'];
          var gaji = jsonDecode(response.body)['data']['salary'];
          var verified = jsonDecode(response.body)['data']['verify'];

          await prefs.setString('email', email);
          await prefs.setString('idUser', idUser);
          await prefs.setString('nama', nama);
          await prefs.setString('nohp', nohp);
          await prefs.setString('posisi', job);
          await prefs.setBool('superUser', superUser);
          await prefs.setInt('gaji', gaji);
          await prefs.setString('idCategory', idCategory);
          await prefs.setString('category', category);
          await prefs.setString('idCompany', idCompany);
          await prefs.setString('company', company);
          await prefs.setString('image', image);
          await prefs.setBool('isAbsen', isAbsen);
          await prefs.setString('jobType', jobType);
          await prefs.setBool('verify', verified);

          ShowAlert.alertSuccessWithRoutePushRemove(
              context, "Berhasil Login", BottomNav());
        }
      } else {
        ShowAlert.alertFailedWithNavigatePop(
            context, jsonDecode(response.body)['message']);
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }
}

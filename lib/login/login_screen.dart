import 'dart:convert';

import 'package:absen_sek/bottomnav.dart';
import 'package:absen_sek/helpers/alert.dart';

import 'package:absen_sek/network/network.dart';
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

    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('ok33g3nd!:okk3pl0nt!'));

    try {
      var response = await http.post(Uri.parse(BaseURL.domain + "/login"),
          headers: {
            "Content-Type": "application/json",
            "authorization": basicAuth
          },
          body: body);

      var message = jsonDecode(response.body)['message'];

      print(response.body);

      if (response.statusCode == 200) {
        var token = jsonDecode(response.body)['data']['token'];
        var idUser = jsonDecode(response.body)['data']['user']['_id'];
        var nama = jsonDecode(response.body)['data']['user']['nama'];
        var nohp = jsonDecode(response.body)['data']['user']['nohp'];
        var posisi = jsonDecode(response.body)['data']['user']['posisi'];
        var superUser = jsonDecode(response.body)['data']['user']['superUser'];
        var gaji = jsonDecode(response.body)['data']['user']['gaji'];

        await prefs.setString('email', emailController.text);
        await prefs.setString('token', token);
        await prefs.setString('idUser', idUser);
        await prefs.setString('nama', nama);
        await prefs.setString('nohp', nohp);
        await prefs.setString('posisi', posisi);
        await prefs.setBool('superUser', superUser);
        await prefs.setInt('gaji', gaji);

        ShowAlert.alertSuccessWithRoutePushRemove(
            context, message, BottomNav());
      } else {
        ShowAlert.alertFailedWithNavigatePop(context, message);
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }
}

import 'dart:convert';

import 'package:absen_sek/constant.dart';
import 'package:absen_sek/helpers/alert.dart';
import 'package:absen_sek/network/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nohpController = TextEditingController();
  TextEditingController posisiController = TextEditingController();
  TextEditingController gajiController = TextEditingController();

  bool securePassword = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Membuat akun karyawan",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 30),
                Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Constant.yellowPrim, width: 4),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage("assets/images/zoro.jpg")))),
                SizedBox(height: 20),
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.mail_outlined),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: securePassword,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key_outlined),
                      hintText: "Password",
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
                SizedBox(height: 20),
                TextField(
                  controller: nohpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Telp Number",
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: posisiController,
                  decoration: InputDecoration(
                    hintText: "Job",
                    prefixIcon: Icon(Icons.source_outlined),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: gajiController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Salary",
                    prefixIcon: Icon(Icons.monetization_on_outlined),
                  ),
                ),
                SizedBox(height: 35),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      register();
                    },
                    child: loading
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : const Text(
                            "Register",
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ),
                SizedBox(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }

  register() async {
    try {
      setState(() {
        loading = true;
      });

      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('ok33g3nd!:okk3pl0nt!'));

      var body = jsonEncode({
        "nama": namaController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "nohp": nohpController.text,
        "posisi": posisiController.text,
        "gaji": gajiController.text,
      });

      var response = await http.post(Uri.parse(BaseURL.domain + "/register"),
          headers: {
            "Content-Type": "application/json",
            "authorization": basicAuth
          },
          body: body);

      var message = jsonDecode(response.body)['message'];

      print(response.body);

      if (response.statusCode == 200) {
        Alert(
          context: context,
          type: AlertType.success,
          title: message,
          buttons: [
            DialogButton(
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
              width: 120,
              child: const Text(
                "Okey",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            )
          ],
        ).show();
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: message,
          buttons: [
            DialogButton(
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
              width: 120,
              child: const Text(
                "Okey",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            )
          ],
        ).show();
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }
}

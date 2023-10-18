// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:absen_sek/network/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uploadcare_client/uploadcare_client.dart';
import 'package:http/http.dart' as http;

class FaceRegistrationScreen extends StatefulWidget {
  final String email;
  final String password;
  const FaceRegistrationScreen(
      {Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State<FaceRegistrationScreen> createState() => _FaceRegistrationScreenState();
}

class _FaceRegistrationScreenState extends State<FaceRegistrationScreen> {
  bool loading = false;

  File? imageFile;
  late String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Face Registration"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 37),
          child: Column(
            children: [
              Text(
                "Foto Wajah",
                style: TextStyle(
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  imageSelector(context);
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: imageFile == null
                      ? Icon(
                          CupertinoIcons.camera,
                          size: 150,
                        )
                      : Image.file(imageFile!),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (imageFile == null) {
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "Foto Dulu",
                        buttons: [
                          DialogButton(
                            onPressed: () =>
                                Navigator.of(context, rootNavigator: true)
                                    .pop(),
                            width: 120,
                            child: const Text(
                              "Okey",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          )
                        ],
                      ).show();
                    } else {
                      uploadcare(imageFile);
                    }
                  },
                  child: loading
                      ? CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : Text(
                          "Daftarkan Sekarang",
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future imageSelector(BuildContext context) async {
    var jepret = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (jepret != null) {
      print("You selected  image : " + jepret.path);
      setState(() {
        imageFile = File(jepret.path);
        debugPrint("SELECTED IMAGE PICK   $imageFile");
      });
    } else {
      print("You have not taken image");
    }
  }

  uploadcare(file) async {
    try {
      setState(() {
        loading = true;
      });
      final options = ClientOptions(
          authorizationScheme: AuthSchemeRegular(
        apiVersion: 'v0.5',
        publicKey: '13d6296f5980c22e9805',
        privateKey: '2b8f7318d600f9233a94',
      ));

      final upload = ApiUpload(options: options);
      final fileId = await upload.base(UCFile(file));

      setState(() {
        imageFile = null;
        imageUrl = "https://ucarecdn.com/" + fileId.toString() + "/";
      });

      await register();
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  register() async {
    var body = jsonEncode({
      "email": widget.email,
      "password": widget.password,
      "image": imageUrl
    });

    var response = await http.post(Uri.parse(BaseURL.domain + "/unregister"),
        headers: {"Content-Type": "application/json"}, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Berhasil registrasi wajah! coba login besok"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      var msg = jsonDecode(response.body)['message'];
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

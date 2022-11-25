import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:absen_sek/absen/izin_screen.dart';
import 'package:absen_sek/constant.dart';
import 'package:absen_sek/helpers/alert.dart';
import 'package:absen_sek/helpers/basic_auth.dart';
import 'package:absen_sek/home/cek.dart';
import 'package:absen_sek/models/cek.dart';
import 'package:absen_sek/network/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uploadcare_client/uploadcare_client.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  bool masuk = false;
  bool pulang = false;

  late Future<Cek> cek;
  late ServiceCek service;
  String? nama, posisi;
  int? gaji;

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  late String imageUrl;
  File? imageFile;

  @override
  void initState() {
    checkGps();
    service = ServiceCek();
    fetch();
    getUser();
    super.initState();
  }

  getUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama');
      posisi = prefs.getString('posisi');
      gaji = prefs.getInt('gaji');
    });
  }

  fetch() async {
    cek = service.cekAbsen();
    setState(() {
      cek = cek;
    });
  }

  Future<Null> refresh() async {
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.backgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 37),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        ' $nama',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.topRight,
                    child: FutureBuilder<Cek>(
                      future: cek,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!;
                          masuk = data.data.masuk;
                          pulang = data.data.pulang;

                          return Text(data.message);
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Constant.yellowPrim, width: 4),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("assets/images/zoro.jpg")))),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '$posisi',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Rp. $gaji",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
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
                            title: "Foto Dulu !",
                            buttons: [
                              DialogButton(
                                onPressed: () =>
                                    Navigator.of(context, rootNavigator: true)
                                        .pop(),
                                width: 120,
                                child: const Text(
                                  "Okey",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
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
                              "Absen",
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  ),
                  SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => IzinScreen()),
                      );
                    },
                    child: Text(
                      "Izin tidak masuk",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  checkGps() async {
    bool servicestatus = await Geolocator.isLocationServiceEnabled();

    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
  }

  getLocation() async {
    print("oke");
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("Masuk getLocation()");
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    setState(() {
      long = position.longitude.toString();
      lat = position.latitude.toString();
    });

    // setState(() {
    //   //refresh UI
    // });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457
      print("hee");

      setState(() {
        long = position.longitude.toString();
        lat = position.latitude.toString();
      });

      // setState(() {
      //   //refresh UI on update
      // });
    });
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

      absen();
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  absen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUser = pref.getString("idUser");

    if (masuk == false && pulang == false) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Maaf belum boleh absen ya"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      var body = jsonEncode({
        "id": idUser,
        "ket": masuk ? "masuk" : "pulang",
        "foto": imageUrl,
        "lat": lat,
        "long": long
      });

      var basic = await BasicAuth().getBasic();

      var response = await http.post(Uri.parse(BaseURL.domain + "/absen"),
          headers: {"Content-Type": "application/json", "authorization": basic},
          body: body);

      var msg = jsonDecode(response.body)['message'];

      if (response.statusCode == 200) {
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
      } else {
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
}

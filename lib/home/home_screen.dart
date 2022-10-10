import 'package:absen_sek/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  children: const [
                    Text(
                      "Hello",
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      " Roronoa",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.topRight,
                  child: Text("Saatnya Absen!"),
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
                            "Back End Engineer",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            "Rp. 8.150.000",
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
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Icon(
                      CupertinoIcons.camera,
                      size: 150,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Absen",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                InkWell(
                  onTap: () {},
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
    );
  }
}

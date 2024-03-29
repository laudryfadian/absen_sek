import 'package:absen_sek/constant.dart';
import 'package:absen_sek/models/history.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class HistoryDetailScreen extends StatelessWidget {
  final Data data;
  const HistoryDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Detail History"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.date,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    data.time,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Image.network(data.image),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${data.lat}, ${data.long}",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    data.approve ? "Approve" : "Not Approve",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: data.approve ? Colors.green : Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: OpenStreetMapSearchAndPick(
                  center:
                      LatLong(double.parse(data.lat), double.parse(data.long)),
                  onPicked: (PickedData pickedData) {},
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    MapsLauncher.launchCoordinates(
                      double.parse(data.lat),
                      double.parse(data.long),
                    );
                  },
                  child: const Text(
                    "Google Maps",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

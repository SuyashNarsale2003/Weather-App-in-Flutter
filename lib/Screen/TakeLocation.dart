import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Screen/weather_home.dart';

double? lat;
double? lon;

TextEditingController? latController = TextEditingController();
TextEditingController? lonController = TextEditingController();

class TakeLocation extends StatefulWidget {
  const TakeLocation({super.key});

  @override
  State<TakeLocation> createState() => _TakeLocationState();
}

class _TakeLocationState extends State<TakeLocation> {
  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    } else {
      print("Permission got");
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lat = currentPosition.latitude;
      print(lat);
      lon = currentPosition.longitude;
      print(lon);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const WeatherHome()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter Latitude and Longitude Manually",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 49, 100, 239)),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 141, 32, 160)),
              width: 200,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40),
                child: Center(
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: latController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Latitude',
                          hintStyle: TextStyle(color: Colors.white))),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 141, 32, 160)),
              width: 200,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40),
                child: Center(
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: lonController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Longitude',
                          hintStyle: TextStyle(color: Colors.white))),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    lat = double.parse(latController!.text);
                    print(lat);
                    lon = double.parse(lonController!.text);
                    print(lon);
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WeatherHome()));
                },
                child: const Text("Go Forword")),
            const SizedBox(
              height: 15,
            ),
            const Text("OR"),
            ElevatedButton(
                onPressed: () {
                  getCurrentPosition();
                },
                child: const Text("Get Current Location")),
          ],
        ),
      ),
    );
  }
}

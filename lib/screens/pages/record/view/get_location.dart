import 'package:etrafficcomplainer/screens/pages/record/controller/get_location_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LocationFieldWidget extends StatefulWidget {
  @override
  _LocationFieldWidgetState createState() => _LocationFieldWidgetState();
}

class _LocationFieldWidgetState extends State<LocationFieldWidget> {
  final locationController = Get.find<GetLocationController>();
  var locationMessage = "";

  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    setState(() {
      locationMessage = "$position";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 46.0,
              color: Colors.blue,
            ),
            SizedBox(height: 10.0,),
            Text("get user location", style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0,),
            Text("Position : $locationMessage"),
            FlatButton(
                onPressed: () {
                  getCurrentLocation();

                },
                color: Colors.blue,
                child: Text("Get current location", style: TextStyle(color: Colors.white),)
            )
          ],
        ),
      ),

    );
  }


}
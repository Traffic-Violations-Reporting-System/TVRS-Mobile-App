import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:etrafficcomplainer/screens/home/controller/home_controller.dart';
import 'package:etrafficcomplainer/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        backwardsCompatibility: false,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () {
                // Get.defaultDialog(title: "This is dialog");
                //Get.snackbar("Title", "This is getx snackbar", snackPosition: SnackPosition.BOTTOM);
                Get.toNamed("/login");
              },
              child: Text("Logout"),
              color: Colors.red,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

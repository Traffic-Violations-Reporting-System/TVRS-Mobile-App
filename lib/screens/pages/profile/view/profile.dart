
import 'package:etrafficcomplainer/screens/pages/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {

  final primaryColor = Color(0xFF414B70);
  final whiteColor = Color(0xFFFFFFFF);
  final backgroundGradient = LinearGradient(colors: [Colors.white, Color(0xFFEEEEEC)], begin: Alignment.topCenter, end: Alignment.bottomCenter,);
  final secondaryColor = Color(0xFF8E92A8);
  final borderEnableColor = Color(0xFFF6F6F6);
  final hintTextColor = Color(0xFFB2B5C4);
  final dropshadowColor = Color(0x1A4B4B4B);
  final redColor = Color(0xFFFF6666);

  @override
  Widget build(BuildContext context) {
    print("Profile is build!");
    return SafeArea(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    // Get.defaultDialog(title: "This is dialog");
                    //Get.snackbar("Title", "This is getx snackbar", snackPosition: SnackPosition.BOTTOM);
                    //Get.toNamed("/login");
                  },
                  child: Text("Profile"),
                  color: Colors.red,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        )
    );
  }
}
import 'package:etrafficcomplainer/screens/pages/settings/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends GetView<SettingsController> {

  final primaryColor = Color(0xFF414B70);
  final whiteColor = Color(0xFFFFFFFF);
  final backgroundColor = Color(0xFFF6F6F6);
  final backgroundGradient = LinearGradient(colors: [Colors.white, Color(0xFFEEEEEC)], begin: Alignment.topCenter, end: Alignment.bottomCenter,);
  final secondaryColor = Color(0xFF8E92A8);
  final borderEnableColor = Color(0xFFF6F6F6);
  final hintTextColor = Color(0xFFB2B5C4);
  final dropshadowColor = Color(0x1A4B4B4B);
  final redColor = Color(0xFFFF6666);
  final yellowColor = Color(0xFFFFBE15);
  final greenColor = Color(0xFF67C2C9);
  final dropshadowColor2 = Color(0xFF4B4B4B).withOpacity(0.15);

  @override
  Widget build(BuildContext context) {
    print("Settings is build!");
    return SafeArea(
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: backgroundGradient,
              image: DecorationImage(
                  image: AssetImage("assets/img/back_vec_1.png"),
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,top: 70,right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Settings",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontSize: 22,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.home,
                                    color: primaryColor,
                                  ),
                                  Icon(
                                    Icons.dehaze,
                                    color: primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 20,),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}
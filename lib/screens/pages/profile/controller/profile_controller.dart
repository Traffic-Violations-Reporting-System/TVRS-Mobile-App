import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/core/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDataController extends GetxController {
  final redColor = Color(0xFFFF6666);
  final baseUrl = "http://3.139.55.67:4000/api/v1/mobile";
  UserProfile? userProfile;

  @override
  void onInit(){
    getMyProfileData();
    super.onInit();
  }

  void getMyProfileData() async{
    try {
      // EasyLoading.show(status: "Loading...");
      final String myAuthToken = await _getMyAuthToken();
      final response = await Dio().get(baseUrl+"/user/getUserProfileData", options: Options(headers: {
        "Authorization": "$myAuthToken",
      }));
      if (response.statusCode == 200) {
        //create widget list

        print(response.data);
        if((response.data['result'] as List).isNotEmpty) {

          userProfile = UserProfile.fromJson(response.data['result'][0]['mobile_user']);
          // userProfileList = (response.data['result'][0]['mobile_user'] as List)
          //     .map((userProfile) => UserProfile.fromJson(userProfile))
          //     .toList().reversed.toList();
          print("*******");

        }

      }
      // EasyLoading.dismiss();
      update();
    } on DioError catch (error) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
      print('${error.response?.statusCode} : ${error.response}');
    }
  }
  void myListErrorHandler(DioError error){
    EasyLoading.dismiss();
    Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
    print('${error.response?.statusCode} : ${error.response}');
  }
  _getMyAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('AuthToken') ?? "";
  }

}
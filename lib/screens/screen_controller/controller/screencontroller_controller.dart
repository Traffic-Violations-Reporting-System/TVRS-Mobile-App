import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreencontrollerController extends GetxController{

  late ApiService _apiservice;
  final redColor = Color(0xFFFF6666);

  ScreencontrollerController(){
    _apiservice = Get.find<ApiServiceImpl>();
    _apiservice.init();
    isLogged();
  }

  Future isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String status = prefs.getString('USER_STATUS') ?? "";
    switch(status){
      case "REGISTER_ONLY":
        return Get.offNamed("/otp_verify");
      case "LOGGED":
        return loginUser();
      default:
        return Get.offNamed("/register");
    }
  }

  void loginUser() async{

    EasyLoading.show(status: "Loading...");

    final response = await _apiservice.getRequest("/user/auth/validate", loginErrorHandler);

    if (response?.statusCode == 200) {
      EasyLoading.dismiss();
      print(response);
      Get.offAllNamed("/home");
    }

  }

  void loginErrorHandler(DioError error){
    if (error.response?.statusCode == 401) {
      EasyLoading.dismiss();
      Get.snackbar("Token Expired!", "Your authentication token is expired. Please login again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.exclamationmark_circle_fill, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0), snackbarStatus: (status) {
        if(status == SnackbarStatus.CLOSED){
          Get.offAllNamed("/login");
        }
      });
      print('${error.response?.statusCode} : ${error.response}');
    } else{
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong! Please login again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),snackbarStatus: (status) {
        if(status == SnackbarStatus.CLOSED){
          Get.offAllNamed("/login");
        }
      });
      print('${error.response?.statusCode} : ${error.response}');
    }
  }

}
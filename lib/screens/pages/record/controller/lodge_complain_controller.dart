import 'dart:io';

import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LodgeComplainController extends GetxController{
  final lodgeComplainFormKey = GlobalKey<FormState>();
  final messageController = TextEditingController();
  int radioValue = 0;
  final primaryColor = Color(0xFF414B70);
  final redColor = Color(0xFFFF6666);

  late ApiService _apiservice;

  LodgeComplainController(){
    _apiservice = Get.find<ApiServiceImpl>();
    _apiservice.init();
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void lodgeComplaint(File file, Position location) async {

    if(lodgeComplainFormKey.currentState!.validate()){
      EasyLoading.showProgress(0, status: "Uploading...");
      try {

        final response1 = await _apiservice.getRequest("/video-upload/get-signed-url");

        if (response1.statusCode == 200) {
          final String preSignedUrl = response1.data.url;

          final response2 = await _apiservice.putRequest(preSignedUrl, file);

          if (response2.statusCode == 200) {

            final response3 = await _apiservice.postRequest("/user/verifyotp", {
              'message': messageController.text.trim(),
              'location': location,
              'complainant': radioValue == 1? "non-victim" : "victim"
            });

            if (response3.statusCode == 200) {
              EasyLoading.dismiss();
              Get.snackbar("Verification Success", "We have successfully verified your mobile number.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: primaryColor, icon: Icon(CupertinoIcons.checkmark_alt_circle_fill, color: primaryColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: false, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0), snackbarStatus: (status) {
                if(status == SnackbarStatus.CLOSED){
                  Get.offAllNamed("/home");
                }
              },);
            }
            else if (response3.statusCode == 400) {
              EasyLoading.dismiss();
              Get.snackbar("OTP Failed!", "Otp verification failed. Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 3), colorText: redColor, icon: Icon(CupertinoIcons.info_circle_fill, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
              print('${response3.statusCode} : ${response3.data.toString()}');
            }
            else{
              EasyLoading.dismiss();
              Get.snackbar("Error", "Something went wrong! Please verify again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
              print('${response3.statusCode} : ${response3.data.toString()}');
            }

          }

        }

      } catch (error) {
        EasyLoading.dismiss();
        print(error);
        Get.snackbar("OTP Failed!", "Otp verification failed. Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 3), colorText: redColor, icon: Icon(CupertinoIcons.info_circle_fill, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
      }
    }

  }

}
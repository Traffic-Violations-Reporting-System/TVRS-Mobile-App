
import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class OTPVerify2Controller extends GetxController{

  final primaryColor = Color(0xFF414B70);
  final redColor = Color(0xFFFF6666);

  final otpFormKey = GlobalKey<FormState>();
  final dynamic dataset = Get.arguments;
  bool isComplete = false;
  RxBool isTapVerifyBtn = false.obs;

  late ApiService _apiservice;

  OTPVerify2Controller(){
    _apiservice = Get.find<ApiServiceImpl>();
    _apiservice.init();
  }

  void otpVerify(String otp) async{
    if(isComplete){
      isTapVerifyBtn.value = false;
      EasyLoading.show(status: "Checking...");
      try {

        final response = await _apiservice.postRequest("/otpverify", {
          'otp': otp
        });

        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          Get.snackbar("Verification Success", "We have successfully verified your mobile number.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: primaryColor, icon: Icon(CupertinoIcons.checkmark_alt_circle_fill, color: primaryColor), backgroundColor: Colors.white70, overlayColor: Colors.black.withOpacity(0.6) , overlayBlur: 0.001, isDismissible: false, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0), snackbarStatus: (status) {
            if(status == SnackbarStatus.CLOSED){
              Get.offAllNamed("/home");
            }
          },);
        } else{
          EasyLoading.dismiss();
          Get.snackbar("Error", "Something went wrong! Please verify again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Colors.black.withOpacity(0.6) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
          print('${response.statusCode} : ${response.data.toString()}');
        }

      } catch (error) {
        print(error);
      }
    }else{
      isTapVerifyBtn.value = true;
    }
  }

  String getMno(){
    return dataset?['mphone'];
  }

}

import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/core/helpers/custom_dialog_helper.dart';
import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPVerify2Controller extends GetxController{

  final primaryColor = Color(0xFF414B70);
  final redColor = Color(0xFFFF6666);

  final otpFormKey = GlobalKey<FormState>();
  final otpCodeController = TextEditingController();
  final dynamic dataset = Get.arguments;
  bool isComplete = false;
  RxBool isTapVerifyBtn = false.obs;

  late ApiService _apiservice;
  late CustomDialogHelper _customDialogHelper;

  OTPVerify2Controller(){
    _apiservice = Get.find<ApiServiceImpl>();
    _apiservice.init();
    _customDialogHelper = Get.find<CustomDialogHelper>();
  }

  void otpVerify(String otp) async{

    //return _customDialogHelper.showCustomDialog2(context);

    if(isComplete){
      isTapVerifyBtn.value = false;
      EasyLoading.show(status: "Checking...");

      final response = await _apiservice.postRequest("/user/verifyotp", {
        'nic': dataset?['nic'],
        'otp': otp
      }, otpVerifyErrorHandler);

      if (response?.statusCode == 200) {
        EasyLoading.dismiss();
        Get.snackbar("Verification Success", "We have successfully verified your mobile number.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: primaryColor, icon: Icon(CupertinoIcons.checkmark_alt_circle_fill, color: primaryColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: false, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
          snackbarStatus: (status) async {
          if(status == SnackbarStatus.CLOSED){
            await _saveMyAuthToken(response?.data['token']);
            Get.offAllNamed("/home");
          }
        },);
      }


    }else{
      isTapVerifyBtn.value = true;
    }
  }

  void resendOTP() async{

    EasyLoading.show(status: "Sending...");

    final response = await _apiservice.postRequest("/user/resendotp", {
      'nic': dataset?['nic'],
    }, otpResendErrorHandler);

    if (response?.statusCode == 200) {
      EasyLoading.dismiss();
      Get.snackbar("Sent", "We sent a 6-digit OTP code to your mobile number.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: primaryColor, icon: Icon(CupertinoIcons.checkmark_alt_circle_fill, color: primaryColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: false, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0), snackbarStatus: (status) {
        if(status == SnackbarStatus.CLOSED){
          otpCodeController.text = "";
          update();
        }
      },);
    }

  }

  String getMno(){
    return dataset?['mphone'];
  }

  _saveMyAuthToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('AuthToken', token);
    prefs.setString('USER_STATUS', "LOGGED");
  }

  void otpVerifyErrorHandler(DioError error){
    if (error.response?.statusCode == 400) {
      EasyLoading.dismiss();
      Get.snackbar("Invalid OTP!", "Otp verification failed. Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.info_circle_fill, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
      print('${error.response?.statusCode} : ${error.response}');
    }
    else if (error.response?.statusCode == 405) {
      EasyLoading.dismiss();
      Get.snackbar("OTP Expired!", "Otp verification failed. Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clock_fill, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
      print('${error.response?.statusCode} : ${error.response}');
    }
    else{
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
      print('${error.response?.statusCode} : ${error.response}');
    }
  }

  void otpResendErrorHandler(DioError error){
    EasyLoading.dismiss();
    Get.snackbar("Error", "Something went wrong! Please resend again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
    print('${error.response?.statusCode} : ${error.response}');
  }

}
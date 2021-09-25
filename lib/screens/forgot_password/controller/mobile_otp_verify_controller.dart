import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/core/helpers/custom_dialog_helper.dart';
import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class MobileOtpVerifyController extends GetxController{
  final primaryColor = Color(0xFF414B70);
  final redColor = Color(0xFFFF6666);

  final otpFormKey = GlobalKey<FormState>();
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
      try {

        final response = await _apiservice.postRequest("/user/verifyotp", {
          'mphone': dataset?['mphone'],
          'otp': otp
        }, errorHandler);

        if (response?.statusCode == 200) {
          EasyLoading.dismiss();
          Get.snackbar("Verification Success", "We have successfully verified your mobile number.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: primaryColor, icon: Icon(CupertinoIcons.checkmark_alt_circle_fill, color: primaryColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: false, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0), snackbarStatus: (status) {
            if(status == SnackbarStatus.CLOSED){
              // Get.offAllNamed("forgot_password");
              Get.offNamed("/forgot_password", arguments: {
                'mphone': dataset?['mphone'],
              });
            }
          },);
        }
        else if (response?.statusCode == 400) {
          EasyLoading.dismiss();
          Get.snackbar("OTP Failed!", "Otp verification failed. Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 3), colorText: redColor, icon: Icon(CupertinoIcons.info_circle_fill, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
          print('${response?.statusCode} : ${response?.data.toString()}');
        }

      } catch (error) {
        EasyLoading.dismiss();
        print(error);
        Get.snackbar("OTP Failed!", "Otp verification failed. Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 3), colorText: redColor, icon: Icon(CupertinoIcons.info_circle_fill, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
      }
    }else{
      isTapVerifyBtn.value = true;
    }
  }

  void resendOTP() async{

    if(isComplete){
      EasyLoading.show(status: "Sending...");
      try {

        final response = await _apiservice.postRequest("/user/resendForgotPasswordotp", {
          'mphone': dataset?['mphone'],
        }, errorHandler);

        if (response?.statusCode == 200) {
          EasyLoading.dismiss();
          Get.snackbar("Sent", "We sent a 6-digit OTP code to your mobile number.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: primaryColor, icon: Icon(CupertinoIcons.checkmark_alt_circle_fill, color: primaryColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: false, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0), snackbarStatus: (status) {
            if(status == SnackbarStatus.CLOSED){
              otpFormKey.currentState?.reset();
            }
          },);
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

  void errorHandler(DioError error){
    EasyLoading.dismiss();
    Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
    print('${error.response?.statusCode} : ${error.response}');
  }

}
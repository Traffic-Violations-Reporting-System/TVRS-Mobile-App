import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class OTPVerifyController extends GetxController{

  final primaryColor = Color(0xFF414B70);
  final redColor = Color(0xFFFF6666);

  final mnoFormKey = GlobalKey<FormState>();

  final dynamic dataset = Get.arguments;

  late ApiService _apiservice;

  OTPVerifyController(){
    _apiservice = Get.find<ApiServiceImpl>();
    _apiservice.init();
  }

  void sendOTP(String mphone) async{
    if(mnoFormKey.currentState!.validate()){
      EasyLoading.show(status: "Sending...");
      try {

        final response = await _apiservice.postRequest("/user/sendotp", {
          'nic': dataset?['nic'],
          'mphone': mphone
        });

        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          Get.snackbar("Sent", "We sent a 6-digit OTP code to your mobile number.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: primaryColor, icon: Icon(CupertinoIcons.checkmark_alt_circle_fill, color: primaryColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: false, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0), snackbarStatus: (status) {
            if(status == SnackbarStatus.CLOSED){
              Get.offNamed("/otp_verify_2", arguments: {
                'nic': dataset?['nic'],
                'mphone': mphone
              });
            }
          },);
        } else{
          EasyLoading.dismiss();
          Get.snackbar("Error", "Something went wrong! Please resend again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
          print('${response.statusCode} : ${response.data.toString()}');
        }

      } catch (error) {
        print(error);
      }

    }
  }

  String getWelcomeName(){
    return dataset?['fullName']?.toString().trim().split(" ")[0] ?? "";
  }

}
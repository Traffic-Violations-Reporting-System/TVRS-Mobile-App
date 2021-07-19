import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final loginFormKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final redColor = Color(0xFFFF6666);

  late ApiService _apiservice;

  LoginController(){
    _apiservice = Get.find<ApiServiceImpl>();
    _apiservice.init();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void loginUser() async{
    print(usernameController.value);
    print(passwordController.value);

    if(loginFormKey.currentState!.validate()){
      EasyLoading.show(status: "Loading...");
      try {

        final response = await _apiservice.postRequest("/user/login", {
          'nic': usernameController.text,
          'password': passwordController.text,
        });

        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          Get.offNamed("/home");
        } else if (response.statusCode == 401) {
          EasyLoading.dismiss();
          Get.snackbar("Login Failed", "Your NIC or password is incorrect.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 3), colorText: redColor, icon: Icon(CupertinoIcons.exclamationmark_circle_fill, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
          print('${response.statusCode} : ${response.data.toString()}');
        } else{
          EasyLoading.dismiss();
          Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
          print('${response.statusCode} : ${response.data.toString()}');
        }

      } catch (error) {
        print(error);
        EasyLoading.dismiss();
        Get.snackbar("Login Failed", "Your NIC or password is incorrect.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 3), colorText: redColor, icon: Icon(CupertinoIcons.exclamationmark_circle_fill, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
      }

    }

  }
}
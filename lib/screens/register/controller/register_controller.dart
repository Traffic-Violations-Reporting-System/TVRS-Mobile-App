import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{

  final redColor = Color(0xFFFF6666);

  late ApiService _apiservice;

  RegisterController(){
    _apiservice = Get.find<ApiServiceImpl>();
    _apiservice.init();
  }

  final registerFormKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final nicController = TextEditingController();
  final npdController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void onClose() {
    fullNameController.dispose();
    nicController.dispose();
    npdController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void registerUser() async{
    if(registerFormKey.currentState!.validate()){
      EasyLoading.show(status: "Loading...");
      try {

        final response = await _apiservice.postRequest("/user/register", {
          'fullname': fullNameController.text.trim(),
          'nic': nicController.text.trim(),
          'regionid': npdController.text.split(" - ")[0].trim(),
          'password': confirmPasswordController.text,
        });

        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          Get.offNamed("/otp_verify", arguments: {
            'fullName': fullNameController.text,
            'nic': nicController.text.trim()
          });
        } else if (response.statusCode == 409) {
          EasyLoading.dismiss();
          Get.snackbar("You already have an existing account", "This NIC is already registered. please login into your existing account.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 3), colorText: redColor, icon: Icon(CupertinoIcons.person_circle_fill, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
          print('${response.statusCode} : ${response.data.toString()}');
        } else{
          EasyLoading.dismiss();
          Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
          print('${response.statusCode} : ${response.data.toString()}');
        }

      } catch (error) {
        print(error);
      }

    }
  }

  void loginUser(){
    Get.toNamed("/login");
  }

}
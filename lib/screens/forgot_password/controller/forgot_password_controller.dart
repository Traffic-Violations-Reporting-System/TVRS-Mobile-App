
import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController{
  final redColor = Color(0xFFFF6666);
  late ApiService _apiservice;

  RegisterController(){
    _apiservice = Get.find<ApiServiceImpl>();
    _apiservice.init();
  }
  final dynamic dataset = Get.arguments;
  final forgotFormKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final retypeNewPasswordController = TextEditingController();

  @override
  void onClose() {
    newPasswordController.dispose();
    retypeNewPasswordController.dispose();
    super.onClose();
  }

  void setNewpassword() async{
    if(forgotFormKey.currentState!.validate()){
      EasyLoading.show(status: "Loading...");
      try {

        final response = await _apiservice.postRequest("/user/forgot_password", {
          'newPassword': retypeNewPasswordController.text,
          'mphone': dataset?['mphone'],
        }, errorHandler);

        if (response?.statusCode == 200) {
          EasyLoading.dismiss();
          Get.offNamed("/login", arguments: {
            'newPassword': retypeNewPasswordController.text,
          });
        }

      } catch (error) {
        print(error);
      }

    }
  }

  void loginUser(){
    Get.toNamed('/login');
  }

  void errorHandler(DioError error){
    EasyLoading.dismiss();
    Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
    print('${error.response?.statusCode} : ${error.response}');
  }

}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void loginUser(){
    print(emailController.value);
    print(passwordController.value);

  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{

  final registerFormKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final nicController = TextEditingController();
  final npdController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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

  void registerUser(){

  }

}
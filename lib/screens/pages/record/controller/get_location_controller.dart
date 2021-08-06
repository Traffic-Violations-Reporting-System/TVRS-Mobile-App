import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GetLocationController extends GetxController{
  final getLocationFormKey = GlobalKey<FormState>();
  final locationController = TextEditingController();

  void printValue(){
    print(locationController.value);
  }
  void lodgeComplain(){
    Get.toNamed('/lodge_complain');
  }
}
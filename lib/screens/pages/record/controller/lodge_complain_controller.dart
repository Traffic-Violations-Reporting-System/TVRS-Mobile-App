import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LodgeComplainController extends GetxController{
  final lodgeComplainFormKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final victimController = TextEditingController();

  void lodgeComplain(){
    print(victimController.value);
  }

  void getLocation(){
    Get.toNamed('/get_location');
  }
}
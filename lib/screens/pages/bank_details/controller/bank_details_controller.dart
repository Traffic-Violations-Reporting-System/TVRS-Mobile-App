import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BankDetailsController extends GetxController{

  final bankDetailsFormKey = GlobalKey<FormState>();
  final bankNameController = TextEditingController();
  final branchNameController = TextEditingController();
  final branchCodeController = TextEditingController();
  final accountNoController = TextEditingController();

}
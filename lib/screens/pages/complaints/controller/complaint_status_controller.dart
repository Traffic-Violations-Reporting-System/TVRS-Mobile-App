import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/core/models/complaint_status.dart';
import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintStatusController extends GetxController{
  final redColor = Color(0xFFFF6666);
  final baseUrl = "http://3.139.55.67:4000/api/v1/mobile";

  List<ComplaintStatus>? myStatusList;
  final dynamic dataset = Get.arguments;

  String? getPendingStatusDate(){
    return dataset['createdAt'];
  }
  @override
  void onInit(){
    getMyStatusList();
    super.onInit();
  }
  void getMyStatusList() async{

    try {
      EasyLoading.show(status: "Loading...");
      final String complaintId = dataset['complaint_id'];

      print(complaintId);
      final response = await Dio().get(baseUrl+"/complain/complaintStatus", options: Options(headers: {
        'Authorization': complaintId,
      }));

      print("********");
      print(response);
      if (response.statusCode == 200) {
        //create widget list

        print(response);
        print("3");
        if((response.data['result'] as List).isNotEmpty) {
          print("4");
          myStatusList = (response.data['result'] as List)
              .map((complaintStatus) => ComplaintStatus.fromJson(complaintStatus))
              .toList().reversed.toList();
          print(myStatusList!.length);
          print("5");
        }

      }
      // getComplaintStatus(response.data['result']['id']);
      EasyLoading.dismiss();
      update();
    } on DioError catch (error) {
      print(error);
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
      print('${error.response?.statusCode} : ${error.response}');
    }

  }

  // String? getComplaintStatus(data){
  //   print(data);
  //   return data.toString();
  // }


}
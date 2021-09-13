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

  @override
  void onInit(){
    getMyStatusList();
    super.onInit();
  }

  void getMyStatusList() async{

    try {
      EasyLoading.show(status: "Loading...");
      final String complaint_id = await _getComplaintId();
      final response = await Dio().get(baseUrl+"/complain/viewComplaintStatus", options: Options(headers: {
        "Authorization": "$complaint_id",
      }));
      if (response.statusCode == 200) {
        //create widget list

        print(response);
        if((response.data['result'] as List).isNotEmpty) {

          myStatusList = (response.data['result'][0]['status_tree'] as List)
              .map((complaintStatus) => ComplaintStatus.fromJson(complaintStatus))
              .toList().reversed.toList();
          getComplainantName(response.data[0]['full_name']);
          getComplaintLocation(response.data[0]['region_id']);
          getPoliceDevision(response.data[0]['police_devision']);
          getComplaintId(response.data[0]['complaintId']);
          print("*******");
        }

      }
      EasyLoading.dismiss();
      update();
    } on DioError catch (error) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
      print('${error.response?.statusCode} : ${error.response}');
    }

  }

  _getComplaintId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('complaint_id') ?? "";
  }

  String? getComplainantName(String name){
      return name;
  }
  String? getComplaintLocation(String location){
    return location;
  }
  String? getPoliceDevision(String policeDevision){
    return policeDevision;
  }
  String? getComplaintId(String complaintId){
    return complaintId;
  }
}
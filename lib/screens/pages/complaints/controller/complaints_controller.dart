import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/core/models/complaint.dart';
import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ComplaintsController extends GetxController{

  final redColor = Color(0xFFFF6666);

  late ApiService _apiservice;
  int pageIndex = 0;
  late List<Complaint> myComplainList;

  ComplaintsController(){
    _apiservice = Get.put(ApiServiceImpl());
    _apiservice.init();
    _getMyComplainList();
  }

  int getPageIndex() => pageIndex;

  void changePageIndex(int index){
    pageIndex = index;
    update();
  }

  void _getMyComplainList() async{

    //EasyLoading.show(status: "Loading...");
    try {

      // final response = await _apiservice.getRequest("/complain/viewMyComplaints");
      //
      // if (response.statusCode == 200) {
      //   EasyLoading.dismiss();
      //   //create widget list
      //   myComplainList = (response.data['result'] as List)
      //       .map((complaint) => Complaint.fromJson(complaint))
      //       .toList();
      //   update();
      // }

    }on DioError catch (error) {
      if (error.response?.statusCode == 401) {
        EasyLoading.dismiss();
        Get.snackbar("Authentication Error", "The authentication session has expired. Please Login again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.exclamationmark_circle_fill, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
        Get.offAllNamed("/login");
        print('${error.response?.statusCode} : ${error.message}');
      } else{
        EasyLoading.dismiss();
        Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
        print('${error.response?.statusCode} : ${error.message}');
      }

    }
  }

}
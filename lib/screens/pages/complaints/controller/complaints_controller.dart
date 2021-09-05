import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/core/models/complaint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintsController extends GetxController{

  final redColor = Color(0xFFFF6666);
  final baseUrl = "http://3.139.55.67:4000/api/v1/mobile";

  int pageIndex = 0;
  List<Complaint>? myComplainList;

  @override
  void onInit(){
    getMyComplainList();
    super.onInit();
  }

  int getPageIndex() => pageIndex;

  void changePageIndex(int index){
    pageIndex = index;
    update();
  }

   void getMyComplainList() async{

    try {
      EasyLoading.show(status: "Loading...");
      final String myAuthToken = await _getMyAuthToken();
      final response = await Dio().get(baseUrl+"/complain/viewMyComplaints", options: Options(headers: {
        "Authorization": "$myAuthToken",
      }));
      if (response.statusCode == 200) {
        //create widget list
        print(response);
        if((response.data['result'] as List).isNotEmpty) {
          myComplainList = (response.data['result'][0]['mobile_user']['complaints'] as List)
              .map((complaint) => Complaint.fromJson(complaint, response.data['result'][0]['mobile_user']['nic']))
              .toList().reversed.toList();
        }
        print(myComplainList);
      }
      EasyLoading.dismiss();
      update();
    } on DioError catch (error) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
      print('${error.response?.statusCode} : ${error.response}');
    }

  }

  void myListErrorHandler(DioError error){
    EasyLoading.dismiss();
    Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
    print('${error.response?.statusCode} : ${error.response}');
  }

  _getMyAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('AuthToken') ?? "";
  }

  void tapToRefresh(){
    getMyComplainList();
  }

}
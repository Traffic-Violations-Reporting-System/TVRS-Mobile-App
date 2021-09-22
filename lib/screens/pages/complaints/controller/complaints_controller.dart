import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/core/models/complaint.dart';
import 'package:etrafficcomplainer/core/models/savevideo.dart';
import 'package:etrafficcomplainer/screens/home/controller/home_controller.dart';
import 'package:etrafficcomplainer/screens/pages/record/view/VideoView.dart';
import 'package:etrafficcomplainer/screens/pages/record/view/lodge_complain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintsController extends GetxController{

  final redColor = Color(0xFFFF6666);
  final baseUrl = "http://3.139.55.67:4000/api/v1/mobile";

  int pageIndex = 0;
  List<Complaint>? myComplainList;
  List<SaveVideo>? mySavedVideosList;

  @override
  void onInit(){
    getMyComplainList();
    super.onInit();
  }

  int getPageIndex() => pageIndex;

  void changePageIndex(int index){
    pageIndex = index;
    if(index == 1) _setSavedVideosList();
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
          List<String> cidlist = await _getHideComplaintsList();
          cidlist.forEach((e) => myComplainList!.removeWhere((element) => element.complainID == e));
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

  Future<List<SaveVideo>?> _getVideoDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getStr = prefs.getString('SAVE_VIDEOS_LIST');
    List<SaveVideo>? saveVideosList;
    if(getStr != null){
      saveVideosList = (json.decode(getStr) as List)
          .map<SaveVideo>((item) => SaveVideo.fromJson(item))
          .toList();
    }
    return saveVideosList;
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
    if(pageIndex == 0){
      getMyComplainList();
    }else if(pageIndex == 1){
      _setSavedVideosList();
    }

  }

  void _setSavedVideosList() async{
    EasyLoading.show(status: "Loading...");
    mySavedVideosList = await _getVideoDetails();
    EasyLoading.dismiss();
  }

  saveHideComplaintsList(String complaintID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String hideList = prefs.getString('HIDE_ID_LIST') ?? "";
    hideList += complaintID + ",";
    prefs.setString('HIDE_ID_LIST', hideList);
    tapToRefresh();
  }

  Future<List<String>> _getHideComplaintsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String hideList = prefs.getString('HIDE_ID_LIST') ?? "";
    return hideList.split(",");
  }

  lodgeComplaint(BuildContext context, String path, Position location, String videolength) async{

    late final page;
   // final controllerHome = Get.find<HomeController>();
    var lenList = videolength.split(":");
    int min = int.parse(lenList[0].replaceAll(RegExp('[^0-9]'), ''));
    int sec = int.parse(lenList[1].replaceAll(RegExp('[^0-9]'), ''));
    int lengthSec = min * 60 + sec;
    if(lengthSec > 10){
      page = VideoViewPage(
          path: path,
          location: location,
          fromSaved: true,
      );
    }else{
      page = LodgeComplain(
        path: path,
        location: location,
        isCropped: false,
      );
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => page),
    );

  }

  void gotoStatusScreen(String complaintId, String createdAt, DateTime dateTime) {
    Get.toNamed("/complaintStatus", arguments: {
      'complaint_id': complaintId,
      'createdAt': createdAt,
      'occured_date': dateTime
    });
  }

}
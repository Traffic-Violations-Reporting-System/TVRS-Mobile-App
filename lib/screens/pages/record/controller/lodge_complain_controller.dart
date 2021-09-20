import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/core/models/lodgedvideo.dart';
import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_compress/video_compress.dart';

class LodgeComplainController extends GetxController{
  final lodgeComplainFormKey = GlobalKey<FormState>();
  final messageController = TextEditingController();
  int radioValue = 0;
  final primaryColor = Color(0xFF414B70);
  final redColor = Color(0xFFFF6666);
  late File videoFile;
  String? locationStr;
  String? postcode;
  int minutes = 0;
  int seconds = 0;

  late ApiService _apiservice;

  LodgeComplainController(Position location){
    _apiservice = Get.put(ApiServiceImpl());
    _apiservice.init();
    getLocationAddress(location);
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void lodgeComplaint(Position location) async {

    if(lodgeComplainFormKey.currentState!.validate()){

      double percentage = 0.0;
      EasyLoading.show(status: "Preparing...");
      final response1 = await _apiservice.getRequest("/video-upload/get-signed-url", errorHandler);
      if (response1?.statusCode == 200) {
        final String preSignedUrl = response1?.data['url'];

        var len = await videoFile.length();
        EasyLoading.dismiss();
        try {
          final response2 = await Dio().put(preSignedUrl, data: videoFile.openRead(), options: Options(headers: {
            Headers.contentLengthHeader: len,
          }, contentType: "video/mp4"), onSendProgress: (send,total){
                percentage = (send / total);
                EasyLoading.showProgress(percentage, status: "Uploading...");
          });
          print(response2);

          if (response2.statusCode == 200) {

            DateTime now = DateTime.now();
            final response3 = await _apiservice.postRequest("/complain/create", {
              'message': messageController.text.trim(),
              'location': "${location.latitude}, ${location.longitude}",
              'complainant': radioValue == 1? "non-victim" : "victim",
              'videoReference': preSignedUrl.split('?')[0].split('com/')[1],
              'occured_date': now.toIso8601String(),
              'postcode': postcode
            }, errorHandler);

            if (response3?.statusCode == 200) {
              EasyLoading.dismiss();
              Get.snackbar("Complaint Placed!", "Your complaint is successfully placed.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: primaryColor, icon: Icon(CupertinoIcons.checkmark_alt_circle_fill, color: primaryColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: false, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0), snackbarStatus: (status) async {
                if(status == SnackbarStatus.CLOSED){
                  //video save
                  await GallerySaver.saveVideo(videoFile.path);
                  String savedpath = '/storage/emulated/0/Movies/${basename(videoFile.path)}';
                  _saveLodgedVideoDetails(savedpath, now);
                  videoFile.deleteSync();
                  await VideoCompress.deleteAllCache();

                  Get.offAllNamed("/home");
                }
              },);
            }

          }

        } on DioError catch (error) {
          EasyLoading.dismiss();
          Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
          print('${error.response?.statusCode} : ${error.response}');
        }

      }
    }

  }

  void errorHandler(DioError error){
    EasyLoading.dismiss();
    Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
    print('${error.response?.statusCode} : ${error.response}');
  }

  void discardComplaint() async{
    await VideoCompress.deleteAllCache();
    Get.offAllNamed("/home");
  }

  void getLocationAddress(Position location) async{
    try {
      String url = "https://nominatim.openstreetmap.org/reverse?format=geocodejson&lat=${location.latitude}&lon=${location.longitude}&accept-language=en";
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        List<String> labels = response.data['features'][0]['properties']['geocoding']['label'].toString().split(",");
        labels.removeRange(labels.length-2, labels.length);
        locationStr = labels.join(", ");
        postcode = response.data['features'][0]['properties']['geocoding']['postcode'];
        print(postcode);
      }

    } on DioError catch (error) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
      print('${error.response?.statusCode} : ${error.response}');
    }

    update();

  }

  _saveLodgedVideoDetails(String path, DateTime dateTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getStr = prefs.getString('SAVE_LODGED_VIDEOS_LIST');
    List<LodgedVideo> saveLodgedVideosList =  [];
    if(getStr != null){
      saveLodgedVideosList = (json.decode(getStr) as List)
          .map<LodgedVideo>((item) => LodgedVideo.fromJson(item))
          .toList();
    }
    saveLodgedVideosList.add(LodgedVideo(dateTime: dateTime, path: path));
    String objectList = jsonEncode(saveLodgedVideosList.map<Map<String, dynamic>>((video) => video.toJson()).toList());
    prefs.setString('SAVE_LODGED_VIDEOS_LIST', objectList);
  }

  Future<String?> _getVideoPath(DateTime dateTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getStr = prefs.getString('SAVE_LODGED_VIDEOS_LIST');
    List<LodgedVideo> saveLodgedVideosList =  [];
    String? path;
    if(getStr != null){
      saveLodgedVideosList = (json.decode(getStr) as List)
          .map<LodgedVideo>((item) => LodgedVideo.fromJson(item))
          .toList();

      saveLodgedVideosList.forEach((element) {
          if(element.dateTime!.compareTo(dateTime) == 0){
            path = element.path;
            return;
          }
      });
      return path;
    }
  }

}
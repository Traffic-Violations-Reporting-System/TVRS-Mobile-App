import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/core/models/lodgedvideo.dart';
import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_compress/video_compress.dart';

class UploadComplainController extends GetxController{
  final lodgeComplainFormKey = GlobalKey<FormState>();
  final messageController = TextEditingController();
  int radioValue = 0;
  final primaryColor = Color(0xFF414B70);
  final redColor = Color(0xFFFF6666);
  String? locationStr;
  File? videoFile;
  DateTime? dateTime;
  String? postcode;

  late ApiService _apiservice;

  final ImagePicker _picker = ImagePicker();

  UploadComplainController(){
    _apiservice = Get.put(ApiServiceImpl());
    _apiservice.init();
  }

  @override
  void onClose() {
    //messageController.dispose();
    super.onClose();
  }

  void lodgeComplaint(LocationResult location) async {

    if(lodgeComplainFormKey.currentState!.validate() && dateTime != null && postcode != null){

      double percentage = 0.0;
      EasyLoading.show(status: "Preparing...");
      final response1 = await _apiservice.getRequest("/video-upload/get-signed-url", errorHandler);
      if (response1?.statusCode == 200) {
        final String preSignedUrl = response1?.data['url'];

        var len = await videoFile!.length();
        EasyLoading.dismiss();
        try {
          final response2 = await Dio().put(preSignedUrl, data: videoFile!.openRead(), options: Options(headers: {
            Headers.contentLengthHeader: len,
          }, contentType: "video/mp4"), onSendProgress: (send,total){
            percentage = (send / total);
            EasyLoading.showProgress(percentage, status: "Uploading...");
          });
          print(response2);

          if (response2.statusCode == 200) {

            DateTime now = dateTime!;
            final response3 = await _apiservice.postRequest("/complain/create", {
              'message': messageController.text.trim(),
              'location': "${location.latLng!.latitude}, ${location.latLng!.longitude}",
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
                  String? savedpath = await saveFile(basename(videoFile!.path), videoFile!);
                  _saveLodgedVideoDetails(savedpath??"", now);
                  videoFile!.deleteSync();
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

  void getLocationAddress(LocationResult location) async{
    try {
      String url = "https://nominatim.openstreetmap.org/reverse?format=geocodejson&lat=${location.latLng!.latitude}&lon=${location.latLng!.longitude}&accept-language=en";
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        List<String> labels = response.data['features'][0]['properties']['geocoding']['label'].toString().split(",");
        labels.removeRange(labels.length-2, labels.length);
        locationStr = labels.join(", ");
        postcode = response.data['features'][0]['properties']['geocoding']['postcode'];
        print("postcode");
        print(postcode);
      }

    } on DioError catch (error) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
      print('${error.response?.statusCode} : ${error.response}');
    }

    update();

  }

  void getDeviceVideo() async{
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    videoFile = video!=null? File(video.path) : null;
    update();
  }

  String getFormattedDate(DateTime dateTime){
    return DateFormat("d MMM yy hh:mm a").format(dateTime);
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

  void setDateTime(DateTime dateTime){
    this.dateTime = dateTime;
    update();
  }

  Future<String?> saveFile(String fileName, File file) async {
    late Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/eTrafficComplainer";
          directory = Directory(newPath);
        }
      }

      String savepath = directory.path + "/$fileName";
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        file.copySync(savepath);
        return savepath;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

}
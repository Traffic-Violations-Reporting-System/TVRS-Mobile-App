import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

class UploadComplainController extends GetxController{
  final lodgeComplainFormKey = GlobalKey<FormState>();
  final messageController = TextEditingController();
  int radioValue = 0;
  final primaryColor = Color(0xFF414B70);
  final redColor = Color(0xFFFF6666);
  late File videoFile;
  String? locationStr;
  final ImagePicker _picker = ImagePicker();

  late ApiService _apiservice;

  UploadComplainController(){
    _apiservice = Get.put(ApiServiceImpl());
    _apiservice.init();
  }

  @override
  void onClose() {
    //messageController.dispose();
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

            final response3 = await _apiservice.postRequest("/complain/create", {
              'message': messageController.text.trim(),
              'location': "${location.latitude}, ${location.longitude}",
              'complainant': radioValue == 1? "non-victim" : "victim",
              'videoReference': preSignedUrl.split('?')[0].split('com/')[1]
            }, errorHandler);

            if (response3?.statusCode == 200) {
              EasyLoading.dismiss();
              Get.snackbar("Complaint Placed!", "Your complaint is successfully placed.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: primaryColor, icon: Icon(CupertinoIcons.checkmark_alt_circle_fill, color: primaryColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: false, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0), snackbarStatus: (status) async {
                if(status == SnackbarStatus.CLOSED){
                  //video save
                  await GallerySaver.saveVideo(videoFile.path);
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
        print(locationStr);
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
    print(video?.path);
  }


}
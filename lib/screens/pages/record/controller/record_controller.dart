import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pausable_timer/pausable_timer.dart';

class RecordController extends GetxController{

  RxString time = "00:00".obs;
  int _minutes = 0;
  int _seconds = 0;
  int _countDown = 0;
  late final PausableTimer timer;
  RxBool flash = false.obs;
  RxBool isRecording = false.obs;
  RxBool isPaused = false.obs;
  Position? complainLocation;
  final redColor = Color(0xFFFF6666);

  RecordController(){
    initTimer();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void initTimer() {
       timer = PausableTimer(
      Duration(seconds: 1),
          () {
        _countDown++;
        _seconds = (_countDown%60).truncate();
        _minutes = (_countDown/60).truncate();
        time.value = "${_minutes < 10? '0'+_minutes.toString() : _minutes}:${_seconds < 10? '0'+_seconds.toString() : _seconds}";
        if (_countDown > 0) {
          timer..reset()..start();
        }

      },
    );
  }

  Future<bool> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Get.snackbar("Location Required!", "Please enable location service to continue.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 3), colorText: redColor, icon: Icon(CupertinoIcons.location_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: false, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0), snackbarStatus: (status) async {
        if(status == SnackbarStatus.CLOSED){
          final AndroidIntent intent = new AndroidIntent(
            action: 'android.settings.LOCATION_SOURCE_SETTINGS',
          );
          await intent.launch();
        }
      },);
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        Get.snackbar("Permission required!", "Location permission is required to continue. Please allow.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.location_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: false, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0), snackbarStatus: (status) async {
          if(status == SnackbarStatus.CLOSED){
            permission = await Geolocator.requestPermission();
          }
        },);
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    this.complainLocation = await Geolocator.getCurrentPosition();
    return true;
  }

  void disposeRecording(){
    _countDown = 0;
    _minutes = 0;
    _seconds = 0;
    timer.cancel();
    flash.value = false;
    isRecording.value = false;
    isPaused.value =false;
    time.value = "00:00";
  }

}
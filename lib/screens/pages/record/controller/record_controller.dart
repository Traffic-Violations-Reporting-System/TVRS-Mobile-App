import 'package:etrafficcomplainer/services/api_service.dart';
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

  RecordController(){
    initTimer();
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

  void determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
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
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    this.complainLocation = await Geolocator.getCurrentPosition();
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
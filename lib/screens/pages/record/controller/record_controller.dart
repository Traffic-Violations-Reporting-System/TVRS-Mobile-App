import 'package:etrafficcomplainer/services/api_service.dart';
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

  void disposeRecording(){
    _countDown = 0;
    _minutes = 0;
    _seconds = 0;
    timer.pause();
    flash.value = false;
    isRecording.value = false;
    isPaused.value =false;
    time.value = "00:00";
  }

}
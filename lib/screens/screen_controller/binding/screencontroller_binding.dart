
import 'package:etrafficcomplainer/screens/screen_controller/controller/screencontroller_controller.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:get/get.dart';

class ScreenControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ApiServiceImpl());
    Get.put(ScreencontrollerController());
  }

}
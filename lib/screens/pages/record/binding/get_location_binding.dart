import 'package:etrafficcomplainer/screens/pages/record/controller/get_location_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class GetLocationBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(GetLocationController());
  }

}
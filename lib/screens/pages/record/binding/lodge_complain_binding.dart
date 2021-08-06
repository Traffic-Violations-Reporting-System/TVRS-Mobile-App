import 'package:etrafficcomplainer/screens/pages/record/controller/lodge_complain_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class LodgeComplainBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(LodgeComplainController());
  }

}
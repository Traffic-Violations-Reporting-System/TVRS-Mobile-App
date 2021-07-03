import 'package:get/get.dart';
import 'package:etrafficcomplainer/screens/home/controller/home_controller.dart';
import 'package:etrafficcomplainer/services/api_service.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ApiService());
    Get.put(HomeController());
  }

}
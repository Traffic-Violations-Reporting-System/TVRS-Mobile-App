import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:get/get.dart';
import 'package:etrafficcomplainer/screens/register/controller/register_controller.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ApiServiceImpl());
    Get.put(RegisterController());
  }

}
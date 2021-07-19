import 'package:etrafficcomplainer/screens/login/controller/login_controller.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ApiServiceImpl());
    Get.put(LoginController());
  }

}
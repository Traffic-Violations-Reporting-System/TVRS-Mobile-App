
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:get/get.dart';
import 'package:etrafficcomplainer/screens/otp_verify/controller/otp_verify_controller.dart';

class OTPVerifyBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ApiServiceImpl());
    Get.put(OTPVerifyController());
  }

}
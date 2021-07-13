import 'package:etrafficcomplainer/screens/otp_verify_2/controller/otp_verify_2_controller.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:get/get.dart';


class OTPVerify2Binding extends Bindings{
  @override
  void dependencies() {
    Get.put(ApiServiceImpl());
    Get.put(OTPVerify2Controller());
  }

}
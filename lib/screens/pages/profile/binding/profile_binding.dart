import 'package:etrafficcomplainer/screens/pages/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileDataController());
  }

}
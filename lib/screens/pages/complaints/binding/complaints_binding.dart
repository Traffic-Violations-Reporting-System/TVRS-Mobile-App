import 'package:etrafficcomplainer/screens/pages/complaints/controller/complaints_controller.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:get/get.dart';

class ComplaintsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ApiServiceImpl());
    Get.put(ComplaintsController());
  }

}
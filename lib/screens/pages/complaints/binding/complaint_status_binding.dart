import 'package:etrafficcomplainer/screens/pages/complaints/controller/complaint_status_controller.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class complaintStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiServiceImpl());
    Get.put(ComplaintStatusController());
  }
}
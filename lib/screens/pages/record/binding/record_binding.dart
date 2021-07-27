import 'package:etrafficcomplainer/screens/pages/record/controller/record_controller.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:get/get.dart';

class RecordBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ApiServiceImpl());
    Get.put(RecordController());
  }

}
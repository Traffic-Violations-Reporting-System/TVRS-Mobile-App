import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:get/get.dart';

class RecordController extends GetxController{

  late ApiService _apiservice;

  RecordController(){
    _apiservice = Get.find<ApiServiceImpl>();
    _apiservice.init();
  }

}
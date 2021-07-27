import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:get/get.dart';

class ComplaintsController extends GetxController{

  late ApiService _apiservice;

  ComplaintsController(){
    _apiservice = Get.find<ApiServiceImpl>();
    _apiservice.init();
  }

}
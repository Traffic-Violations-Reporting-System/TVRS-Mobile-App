import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:get/get.dart';

class ComplaintsController extends GetxController{

  late ApiService _apiservice;
  int pageIndex = 0;

  ComplaintsController(){
    _apiservice = Get.put(ApiServiceImpl());
    _apiservice.init();
  }

  int getPageIndex() => pageIndex;

  void changePageIndex(int index){
    pageIndex = index;
    update();
  }

}
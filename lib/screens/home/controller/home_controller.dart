import 'package:get/get.dart';

class HomeController extends GetxController{
  var pageIndex = 0;

  void changePageIndex(int index){
    pageIndex = index;
    update();
  }
}
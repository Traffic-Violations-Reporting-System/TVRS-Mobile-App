import 'package:get/get.dart';

class ProfileDataController extends GetxController {
  int pageIndex = 2;

  int getPageIndex() => pageIndex;

  void changePageIndex(int index){
    pageIndex = index;
    update();
  }
  String getUserName(){
    return 'kasun lakshitha';
  }
  String phone(){
    return '0712470584';
  }
  String Password(){
    return '********';
  }
  String Police(){
    return 'matara';
  }
}
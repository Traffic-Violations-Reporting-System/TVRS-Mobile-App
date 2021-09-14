import 'package:etrafficcomplainer/screens/pages/bank_details/controller/bank_details_controller.dart';
import 'package:get/get.dart';

class BankDetailsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(BankDetailsController());
  }

}
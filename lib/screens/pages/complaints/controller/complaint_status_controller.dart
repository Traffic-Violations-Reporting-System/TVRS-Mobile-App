import 'dart:convert';

import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:get/get.dart';

class ComplaintStatusController extends GetxController{

  final dynamic dataset = Get.arguments;

  late ApiService _apiservice;
  ComplaintStatusController(){
    _apiservice = Get.find<ApiServiceImpl>();
    _apiservice.init();
  }

  String? getComplaintID(){
    // return dataset['complaintId'].toString();
    String complaintId = "00001";
    return complaintId;
  }

  String getFullName(){
    String complaintId = "K.L.Rajapaksha";
    return complaintId;
  }

  String getPoliceDevision(){
    String policeDevision = "PD001 - Colombo Police Head Office";
    return policeDevision;
  }

  String getLocation(){
    String location = "Vijerama Junction";
    return location;
  }

  List getStatusArray(){

    // try{
    //   final response = await _apiservice.postRequest("/complain/complaintStatus", {
    //     'complaint_id': dataset['complaint_id']
    //   });
    //
    //   if (response.statusCode == 200){
    //       var readData = json.decode(response.data);
    //       return readData;
    //   }
    // }catch (error){
    //   print(error);
    // }



    List oo = jsonDecode('[{"date": "2021/08/24","time": "08.09","status": "status #"},{"date": "2021/08/25","time": "08.10","status": "status #"},{"date": "2021/08/25","time": "08.10","status": "status #"},{"date": "2021/08/25","time": "08.10","status": "status #"}]');

    return oo;
  }
}
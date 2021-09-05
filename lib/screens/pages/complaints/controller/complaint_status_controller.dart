import 'dart:convert';

import 'package:etrafficcomplainer/core/models/complaint_status.dart';
import 'package:etrafficcomplainer/services/api_service.dart';
import 'package:etrafficcomplainer/services/api_service_impl.dart';
import 'package:get/get.dart';

class ComplaintStatusController extends GetxController{
  List<ComplaintStatus>? myList;

  @override
  void onInit(){
    super.onInit();
  }


    var json = {

      "result": [
        {
          "full_name": "kasun",
          "region_id": "123",
          "complaints": [
            {
              "location": "matara",
              "status": "pending",
              "updatedAt": "2021-09-02T18:27:55.000Z"
            }
          ]
        }
      ]
    }.toString();

    List<ComplaintStatus>? getMyStatusComplainList() {
      myList =  complaintStatusFromJson(json) as List<ComplaintStatus>?;

       return myList;


    }
















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



  }
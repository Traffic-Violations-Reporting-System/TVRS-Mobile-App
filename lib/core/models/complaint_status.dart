
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ComplaintStatus{
  String? createdAt;
  String? date;
  String? status;
  String? latestStatus;
  IconData? statusIcon;

  ComplaintStatus({this.createdAt, this.date, this.status, this.latestStatus, this.statusIcon});
  String getStatus(){

    switch(this.latestStatus){
      case "pending":
        statusIcon = CupertinoIcons.doc_plaintext;
        return "Pending in the queue.";
      case "accepted":
        statusIcon = CupertinoIcons.check_mark_circled_solid;
        return "Complaint is processing.";
      case "review":
        statusIcon = CupertinoIcons.alarm;
        return "Complaint is under review.";
      case "reject":
        statusIcon = CupertinoIcons.clear_circled_solid;
        return "We are sorry to inform \n you that your complaint \n is rejected. There were \n no traffic violations  \n occured in the incident. \n Thank you!";
      case "completed":
        statusIcon = CupertinoIcons.check_mark_circled_solid;
        return "Complaint is completed.";
      default:
        return "";
    }
  }

  factory ComplaintStatus.fromJson(Map<String, dynamic> data) => ComplaintStatus(
    createdAt: DateFormat("d MMM yy").format(DateTime.parse(data["createdAt"])),
    date: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(data["createdAt"])),
    latestStatus: data["status"],
  );

}
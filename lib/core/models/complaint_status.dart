
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
        statusIcon = CupertinoIcons.pencil;
        return "Pending in the queue.";
      case "accepted":
        statusIcon = CupertinoIcons.phone;
        return "Complaint is processing.";
      case "review":
        statusIcon = CupertinoIcons.alarm;
        return "Complaint is under review.";
      case "reject":
        statusIcon = CupertinoIcons.add_circled;
        return "Complaint is rejected.";
      case "complete":
        statusIcon = CupertinoIcons.ant;
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
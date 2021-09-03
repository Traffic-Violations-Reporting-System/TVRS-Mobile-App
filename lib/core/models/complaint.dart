
import 'package:intl/intl.dart';

class Complaint{

  String? createdAt;
  String? complainID;
  String? latestStatus;
  String? userID;

  Complaint({this.complainID, this.userID, this.createdAt, this.latestStatus});

  String getStatus(){
    switch(this.latestStatus){
      case "pending":
        return "Complain is pending in the queue.";
      case "taken":
        return "Complain is under review.";
      default:
        return "";
    }
  }

  factory Complaint.fromJson(Map<String, dynamic> data, String accountID) => Complaint(
    complainID: data["complainant_id"],
    userID: accountID,
    createdAt: "hhhhhh",//DateFormat("yyyy-MM-dd HH:mm:ss").format("2020-11-09 "),
    latestStatus: data["complaint_status"],
  );



}
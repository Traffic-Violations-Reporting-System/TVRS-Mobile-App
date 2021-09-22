
import 'package:intl/intl.dart';

class Complaint{

  String? createdAt;
  String? complainID;
  String? latestStatus;
  String? userID;
  DateTime? dateTime;

  Complaint({this.complainID, this.userID, this.createdAt, this.latestStatus, this.dateTime});

  String getStatus(){
    switch(this.latestStatus){
      case "pending":
        return "Pending in the queue.";
      case "accepted":
        return "Processing under related police department.";
      case "review":
        return "Complain is under review.";
      case "rejected":
        return "Complain is rejected.";
      case "completed":
        return "Complain is completely executed.";
      default:
        return "";
    }
  }

  factory Complaint.fromJson(Map<String, dynamic> data, String accountID) => Complaint(
    complainID: data["complainant_id"],
    userID: accountID,
    createdAt: DateFormat("d MMM yy").format(DateTime.parse(data["createdAt"])),
    latestStatus: data["complaint_status"],
    dateTime: DateTime.parse(data["occured_date"]
  ));



}
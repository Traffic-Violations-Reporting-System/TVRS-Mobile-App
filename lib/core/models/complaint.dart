
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
        return "Pending in the queue.";
      case "accept":
        return "Processing under related police department.";
      case "review":
        return "Complain is under review.";
      case "reject":
        return "Complain is rejected.";
      case "complete":
        return "Complain is completely executed.";
      default:
        return "";
    }
  }

  factory Complaint.fromJson(Map<String, dynamic> data, String accountID) => Complaint(
    complainID: data["complainant_id"],
    userID: accountID,
    createdAt: DateFormat("d MMM yy").format(DateTime.parse(data["occured_date"])),
    latestStatus: data["complaint_status"],
  );



}
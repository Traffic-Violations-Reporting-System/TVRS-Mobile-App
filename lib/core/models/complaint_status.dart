
import 'package:intl/intl.dart';

class ComplaintStatus{
  String? createdAt;
  String? date;
  String? status;
  String? latestStatus;

  ComplaintStatus({this.createdAt, this.date, this.status, this.latestStatus});
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

  factory ComplaintStatus.fromJson(Map<String, dynamic> data) => ComplaintStatus(
    createdAt: DateFormat("d MMM yy").format(DateTime.parse(data["createdAt"])),
    date: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(data["createdAt"])),
    latestStatus: data["status"],
  );

}
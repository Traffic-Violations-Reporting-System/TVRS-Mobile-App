
class Complaint{

  DateTime? createdAt;
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

  factory Complaint.fromJson(Map<String, dynamic> data) => Complaint(
    complainID: data["id"],
    userID: data["nic"],
    createdAt: DateTime.parse(data["createdAt"]),
    latestStatus: data["status"],
  );



}
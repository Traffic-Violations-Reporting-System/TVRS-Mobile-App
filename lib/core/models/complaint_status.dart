// To parse this JSON data, do
//
//     final complaintStatus = complaintStatusFromJson(jsonString);

import 'dart:convert';

ComplaintStatus complaintStatusFromJson(String str) => ComplaintStatus.fromJson(json.decode(str));

String complaintStatusToJson(ComplaintStatus data) => json.encode(data.toJson());

class ComplaintStatus {
  ComplaintStatus({
    required this.result,
  });

  List<Result> result;

  factory ComplaintStatus.fromJson(Map<String, dynamic> json) => ComplaintStatus(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    required this.fullName,
    required this.regionId,
    required this.complaints,
  });

  String fullName;
  String regionId;
  List<Complaint> complaints;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    fullName: json["full_name"],
    regionId: json["region_id"],
    complaints: List<Complaint>.from(json["complaints"].map((x) => Complaint.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "full_name": fullName,
    "region_id": regionId,
    "complaints": List<dynamic>.from(complaints.map((x) => x.toJson())),
  };
}

class Complaint {
  Complaint({
    required this.location,
    required this.status,
    required this.updatedAt,
  });

  String location;
  String status;
  String updatedAt;

  factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
    location: json["location"],
    status: json["status"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "location": location,
    "status": status,
    "updatedAt": updatedAt,
  };
}

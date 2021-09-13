
import 'package:intl/intl.dart';

class ComplaintStatus{

  String? date;
  String? status;

  ComplaintStatus({this.date, this.status});

  factory ComplaintStatus.fromJson(Map<String, dynamic> data) => ComplaintStatus(
    date: data["date"],
    status: data["status"],
  );

}

import 'package:intl/intl.dart';

class UserProfile{

  String? userName;
  String? phone;
  String? policeDevision;

  UserProfile({this.userName, this.phone, this.policeDevision});

  factory UserProfile.fromJson(Map<String, dynamic> data) => UserProfile(
    userName: data["full_name"],
    policeDevision: data["region_id"],
    phone: data["mphone"],
  );



}
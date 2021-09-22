

import 'package:geolocator/geolocator.dart';

class SaveVideo{

  String? filename;
  String? path;
  String? datetime;
  String? locationStr;
  Position? location;
  String videoLength;

  SaveVideo({this.filename, this.path, this.datetime, this.locationStr, this.location, required this.videoLength});

  factory SaveVideo.fromJson(Map<String, dynamic> data) => SaveVideo(
    filename: data["filename"] ?? "",
    path: data["path"] ?? "",
    datetime: data["datetime"] ?? "",
    locationStr: data["locationStr"],
    location: Position.fromMap(data["location"]),
    videoLength: data["videoLength"],
  );

  Map<String, dynamic> toJson() => {
        'filename': filename ?? "",
        'path': path ?? "",
        'datetime': datetime ?? "",
        'locationStr': locationStr ?? "",
        'location': location ?? "",
        'videoLength': videoLength,
  };

}
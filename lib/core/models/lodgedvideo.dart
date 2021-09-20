

class LodgedVideo{

  DateTime? dateTime;
  String? path;

  LodgedVideo({this.dateTime, this.path});

  factory LodgedVideo.fromJson(Map<String, dynamic> data) => LodgedVideo(
    dateTime: data["dateTime"] ?? "",
    path: data["path"] ?? "",
  );

  Map<String, dynamic> toJson() => {
        'dateTime': dateTime ?? "",
        'path': path ?? "",
  };

}
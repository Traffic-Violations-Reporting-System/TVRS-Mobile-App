

class SaveVideo{

  String? filename;
  String? path;
  String? datetime;
  String? location;

  SaveVideo({this.filename, this.path, this.datetime, this.location});

  factory SaveVideo.fromJson(Map<String, dynamic> data) => SaveVideo(
    filename: data["filename"] ?? "",
    path: data["path"] ?? "",
    datetime: data["datetime"] ?? "",
    location: data["location"],
  );

  Map<String, dynamic> toJson() => {
        'filename': filename ?? "",
        'path': path ?? "",
        'datetime': datetime ?? "",
        'location': location ?? "",
  };

}
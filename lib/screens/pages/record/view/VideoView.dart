import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/core/models/savevideo.dart';
import 'package:etrafficcomplainer/screens/pages/record/view/lodge_complain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_trimmer/video_trimmer.dart';

class VideoViewPage extends StatefulWidget {
  const VideoViewPage({Key? key, required this.path, required this.location}) : super(key: key);
  final String path;
  final Position location;

  @override
  _VideoViewPageState createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {

  final redColor = Color(0xFFFF6666);
  final greenColor = Color(0xFF67C2C9);
  final secondaryColor = Color(0xFF8E92A8);
  final dropshadowColor = Color(0x1A4B4B4B);
  final primaryColor = Color(0xFF414B70);
  final whiteColor = Color(0xFFFFFFFF);
  final matteBalckColor = Color(0xFF171717);
  final yellowColor = Color(0xFFFFBE15);

  final Trimmer _trimmer = Trimmer();

  late final File file;

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;

  double? progress;

  late Subscription _subscription;

  Future<String?> _saveVideo() async {
    String? _value;

    await _trimmer
        .saveTrimmedVideo(startValue: _startValue, endValue: _endValue)
        .then((value) {
      setState(() {
        _value = value;
      });
    });

    return _value;
  }

  void _loadVideo() async {

    _subscription =
    VideoCompress.compressProgress$.subscribe((progress) {
      EasyLoading.showProgress(progress/100, status: 'Compressing...');
    });

    try{
      await VideoCompress.setLogLevel(0);
      MediaInfo? compressedMediaInfo = await VideoCompress.compressVideo(
          widget.path,
          quality: VideoQuality.LowQuality,
          deleteOrigin: true,
          includeAudio: true // It's false by default
      );
      EasyLoading.dismiss();
      file = compressedMediaInfo!.file!;
      _trimmer.loadVideo(videoFile:compressedMediaInfo.file!);
    }catch (e){
      print("VideoCompressionError");
      print(e);
      EasyLoading.dismiss();
      VideoCompress.cancelCompression();
      file = File(widget.path);
      _trimmer.loadVideo(videoFile:file);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  @override
  void dispose() {
    _subscription.unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: IconButton(
            padding: const EdgeInsets.all(0.0),
            icon: Icon(CupertinoIcons.back, color: primaryColor,),
            iconSize: 32.0,
            alignment: Alignment.centerLeft,
            onPressed: () {

            },
          ),
          middle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.videocam_circle, color: primaryColor,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(CupertinoIcons.chevron_right_2, color: primaryColor,
                  size: 10,),
              ),
              Icon(CupertinoIcons.crop, color: primaryColor,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(
                  CupertinoIcons.chevron_right_2, color: secondaryColor,
                  size: 10,),
              ),
              Icon(CupertinoIcons.cloud_upload, color: secondaryColor,),
            ],
          ),
          trailing: SizedBox(width: 48.0,),
        ),
        backgroundColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 44,),
            Expanded(
              child: Stack(
                  children: [
                    VideoViewer(trimmer: _trimmer),
                    Container(
                      height: 23,
                      color: redColor,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.info_circle_fill, color: whiteColor,
                            size: 15,),
                          SizedBox(width: 5.0,),
                          Text(
                            "Crop the video & try to capture hottest minute!",
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                    Center(
                      child: IconButton(
                          padding: EdgeInsets.all(0.0),
                          iconSize: 35,
                          icon: _isPlaying ? Icon(
                            CupertinoIcons.pause_rectangle,
                            color: whiteColor.withOpacity(0.7),
                          )
                              :
                          Icon(
                            CupertinoIcons.play_rectangle,
                            color: whiteColor.withOpacity(0.7),
                          ),
                          onPressed: () async {
                            // !controller.isPaused.isTrue? controller.timer.pause() : controller.timer.start();
                            // controller.isPaused.toggle();
                            bool playbackState = await _trimmer
                                .videPlaybackControl(
                              startValue: _startValue,
                              endValue: _endValue,
                            );
                            setState(() {
                              _isPlaying = playbackState;
                            });
                          }),
                    ),
                  ]
              ),
            ),
            Container(
              color: matteBalckColor,
              padding: EdgeInsets.only(bottom: 3.0),
              child: Center(
                child: TrimEditor(
                  trimmer: _trimmer,
                  showDuration: true,
                  borderPaintColor: yellowColor,
                  circlePaintColor: greenColor,
                  scrubberPaintColor: greenColor,
                  scrubberWidth: 1,
                  viewerHeight: 50.0,
                  viewerWidth: MediaQuery
                      .of(context)
                      .size
                      .width,
                  maxVideoLength: Duration(seconds: 60),
                  onChangeStart: (value) {
                    _startValue = value;
                  },
                  onChangeEnd: (value) {
                    _endValue = value;
                  },
                  onChangePlaybackState: (value) {
                    setState(() {
                      _isPlaying = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 24.0, right: 24.0, top: 16.0, bottom: 32.0),
              color: whiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      height: 49,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: primaryColor, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: dropshadowColor,
                            spreadRadius: 0,
                            blurRadius: 20,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () async {
                          EasyLoading.show(status: "Saving...");
                          //video save
                          await GallerySaver.saveVideo(file.path);
                          String savedpath = '/storage/emulated/0/Movies/${basename(file.path)}';
                          _saveVideoDetails(basename(file.path), savedpath, widget.location);
                          file.deleteSync();
                          await VideoCompress.deleteAllCache();
                          EasyLoading.dismiss();
                          return;
                          Get.snackbar("Saved!", "Your complaint is successfully saved.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: primaryColor, icon: Icon(CupertinoIcons.checkmark_alt_circle_fill, color: primaryColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: false, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0), snackbarStatus: (status) async {
                            if(status == SnackbarStatus.CLOSED){
                              Get.offAllNamed("/home");
                            }
                          },);
                        },
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            backgroundColor: MaterialStateProperty.all(
                                whiteColor),
                            foregroundColor: MaterialStateProperty.all(
                                primaryColor),
                            overlayColor: MaterialStateProperty.all(
                                primaryColor.withOpacity(0.3)),
                            textStyle: MaterialStateProperty.all(TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.square_arrow_down),
                            SizedBox(width: 6.0,),
                            Text("Save")
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0,),
                  Expanded(
                    child: Container(
                      height: 49,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                            color: dropshadowColor,
                            spreadRadius: 0,
                            blurRadius: 20,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          EasyLoading.show(status: "Cropping...");
                          _saveVideo().then((value) {
                            file.deleteSync();
                            EasyLoading.dismiss();
                            if (value!.isNotEmpty) {
                              print("crop file path: " + value);
                              final page = LodgeComplain(
                                  path: value,
                                  location: widget.location,
                                  isCropped: true,
                              );
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => page
                                  )
                              );
                            }
                          });
                        },
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            backgroundColor: MaterialStateProperty.all(
                                primaryColor),
                            foregroundColor: MaterialStateProperty.all(
                                whiteColor),
                            textStyle: MaterialStateProperty.all(TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.crop),
                            SizedBox(width: 6.0,),
                            Text("Crop")
                          ],
                        ),
                        // child: Icon(CupertinoIcons.checkmark, size: 24,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }

  _saveVideoDetails(String filename, String path, Position location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getStr = prefs.getString('SAVE_VIDEOS_LIST');
    List<SaveVideo> saveVideosList =  [];
    if(getStr != null){
      saveVideosList = (json.decode(getStr) as List)
          .map<SaveVideo>((item) => SaveVideo.fromJson(item))
          .toList();
    }
    String now = DateFormat("d MMM yy hh:mm a").format(DateTime.now());
    String? locationStr = await _getLocationAddress(location);
    saveVideosList.add(SaveVideo(filename: filename, path: path, datetime: now, location: locationStr));
    String objectList = jsonEncode(saveVideosList.map<Map<String, dynamic>>((video) => video.toJson()).toList());
    prefs.setString('SAVE_VIDEOS_LIST', objectList);
  }

  Future<String?> _getLocationAddress(Position location) async{
    try {
      String url = "https://nominatim.openstreetmap.org/reverse?format=geocodejson&lat=${location.latitude}&lon=${location.longitude}&accept-language=en";
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        List<String> labels = response.data['features'][0]['properties']['geocoding']['label'].toString().split(",");
        labels.removeRange(labels.length-2, labels.length);
        return labels.join(", ");
      }

    } on DioError catch (error) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong! Please try again.", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2), colorText: redColor, icon: Icon(CupertinoIcons.clear_circled_solid, color: redColor), backgroundColor: Colors.white70, overlayColor: Color(0xFF151929).withOpacity(0.4) , overlayBlur: 0.001, isDismissible: true, margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0));
      print('${error.response?.statusCode} : ${error.response}');
    }

  }

}
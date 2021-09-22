import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:etrafficcomplainer/core/models/savevideo.dart';
import 'package:etrafficcomplainer/screens/pages/record/controller/lodge_complain_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

//enum SingingCharacter { lafayette, jefferson }
class LodgeComplain extends StatelessWidget {


  LodgeComplain({required this.path, required this.location, required this.isCropped, this.notSaved}){
    controller = Get.put(LodgeComplainController(location));
  }
  final String path;
  final Position location;
  final bool isCropped;
  late final controller;
  final bool? notSaved;

  final primaryColor = Color(0xFF414B70);
  final whiteColor = Color(0xFFFFFFFF);
  final backgroundColor = Color(0xFFF6F6F6);
  final secondaryColor = Color(0xFF8E92A8);
  final borderEnableColor = Color(0xFFF6F6F6);
  final hintTextColor = Color(0xFFB2B5C4);
  final dropshadowColor = Color(0x1A4B4B4B);
  final redColor = Color(0xFFFF6666);
  final greenColor = Color(0xFF67C2C9);
  final yellowColor = Color(0xFFFFBE15);
  final Color dividerColor = CupertinoDynamicColor.withBrightness(
    color: Color(0x4C000000),
    darkColor: Color(0x29000000),
  );


  Widget getTextFormField({required String hint, required TextEditingController controller, required Function validator, double paddingTop = 0.0, int maxLines = 1, int? minLines = 1}){
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: TextFormField(
        cursorColor: primaryColor,
        style: TextStyle(fontSize: 18.0,),
        decoration: InputDecoration(
          fillColor: whiteColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          errorStyle: TextStyle(color: redColor),
          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          hintText: hint,
          hintStyle: TextStyle(color: hintTextColor, fontSize: 14.0),
        ),
        controller: controller,
        validator: (value) {
          return validator(value);
        },
        minLines: minLines,
        maxLines: maxLines,
      ),
    );
  }

  final Completer<GoogleMapController> _mapcontroller = Completer();

  Set<Marker> _createMaker(){
    return <Marker>[
      Marker(
          markerId: MarkerId("complain_location"),
          position: LatLng(location.latitude, location.longitude),
      ),
    ].toSet();
  }




  @override
  Widget build(BuildContext context) {

    print("lodge complain screen is build!");
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.videocam_circle, color: primaryColor,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Icon(CupertinoIcons.chevron_right_2, color: primaryColor, size: 10,),
            ),
            Icon(CupertinoIcons.crop, color: primaryColor,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Icon(CupertinoIcons.chevron_right_2, color: primaryColor, size: 10,),
            ),
            Icon(CupertinoIcons.cloud_upload, color: primaryColor,),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      child: Column(
        children: [
          SizedBox(height: 44,),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text("Attachment", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: primaryColor
                ),
                ),
              ),
            ),
          ),
          Divider(color: dividerColor, height: 0.0,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(0.0),
            color: whiteColor,
            child: SizedBox(
              height: 140,
              child: VideoView(path: path, isCropped: isCropped, notSaved: notSaved,)
              ),
          ),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text("Information", style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: primaryColor
                ),
                ),
              ),
            ),
          ),
          Divider(color: dividerColor, height: 0.0,),
          Expanded(
            child: SingleChildScrollView(
                child: Form(
                  key: controller.lodgeComplainFormKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                        child: GoogleMap(
                              liteModeEnabled: true,
                              myLocationButtonEnabled: false,
                              myLocationEnabled: false,
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(location.latitude, location.longitude),
                                zoom: 15.4746,
                              ),
                              markers: _createMaker(),
                              zoomControlsEnabled: true,
                              zoomGesturesEnabled: true,
                              onMapCreated: (GoogleMapController gmController) {
                                _mapcontroller.complete(gmController);
                              },
                        ),
                      ),
                      Container(
                        height: 50.0,
                        color: whiteColor,
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(CupertinoIcons.location_solid, size: 20, color: greenColor,),
                            SizedBox(width: 16.0,),
                            Text("Location: ", style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            ),
                            GetBuilder<LodgeComplainController>(
                              builder: (controller) {
                                return Flexible(
                                  child: controller.locationStr==null? Text("loading...", style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),) :
                                  Marquee(
                                    text: "${controller.locationStr}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    blankSpace: 40.0,
                                    velocity: 50.0,
                                    startAfter: Duration(seconds: 2),
                                    pauseAfterRound: Duration(seconds: 2),
                                    numberOfRounds: 4,
                                  ),
                                );
                              }
                            )
                          ],
                        ),
                      ),
                      Divider(color: dividerColor, height: 0.0,),
                      getTextFormField(hint: "Message", maxLines: 5, minLines: 5, controller: controller.messageController, validator: (value){
                        if(value!.isEmpty){
                          return "Required!";
                        }
                        else{
                          return null;
                        }
                      }),
                      Divider(color: dividerColor, height: 0.0,),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Text("Complainant", style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor
                            ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 52.0,
                        color: whiteColor,
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: GetBuilder<LodgeComplainController>(
                          builder: (controller) {
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  value: 0,
                                  activeColor: yellowColor,
                                  focusColor: secondaryColor,
                                  groupValue: controller.radioValue,
                                  onChanged: (int? value){
                                    controller.radioValue = value!;
                                    controller.update();
                                  },
                                ),
                                SizedBox(width: 16.0,),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Victim", style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    SizedBox(height: 4.0,),
                                    Text("I complain as a victim of the attachment.", style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                )
                              ],
                            );
                          }
                        ),
                      ),
                      Divider(color: dividerColor, height: 0.0,),
                      Container(
                        height: 52.0,
                        color: whiteColor,
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: GetBuilder<LodgeComplainController>(
                          builder: (controller) {
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  value: 1,
                                  activeColor: yellowColor,
                                  focusColor: secondaryColor,
                                  groupValue: controller.radioValue,
                                  onChanged: (int? value){
                                    controller.radioValue = value!;
                                    controller.update();
                                  },
                                ),
                                SizedBox(width: 16.0,),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Non-Victim", style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    SizedBox(height: 4.0,),
                                    Text("I complain as a non-victim of the attachment.", style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ],
                            );
                          }
                        ),
                      ),
                      Divider(color: dividerColor, height: 0.0,),
                      SizedBox(height: 57.0,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        width: double.infinity,
                        height: 53,
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
                            FocusScope.of(context).unfocus();
                            controller.lodgeComplaint(location);
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              backgroundColor: MaterialStateProperty.all(primaryColor),
                              foregroundColor: MaterialStateProperty.all(whiteColor),
                              textStyle: MaterialStateProperty.all(TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ))
                          ),
                          child: Text("Lodge Complaint"),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24.0),
                        width: double.infinity,
                        height: 53,
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
                          onPressed: () async{
                            FocusScope.of(context).unfocus();
                            if(notSaved!=null && notSaved!){
                              EasyLoading.show(status: "Saving...");
                              //video save
                              await GallerySaver.saveVideo(controller.videoFile.path);
                              String savedpath = '/storage/emulated/0/Movies/${basename(controller.videoFile.path)}';
                              String videolength;
                              videolength = "${controller.minutes < 10? '0'+controller.minutes.toString() : controller.minutes}:${controller.seconds < 10? '0'+controller.seconds.toString() : controller.seconds} Min";
                              _saveVideoDetails(basename(controller.videoFile.path), savedpath, location, videolength);
                              await VideoCompress.deleteAllCache();
                              EasyLoading.dismiss();
                              Get.offAllNamed("/home");
                            }else{
                              controller.discardComplaint();
                            }

                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              backgroundColor: MaterialStateProperty.all(backgroundColor),
                              foregroundColor: MaterialStateProperty.all(primaryColor),
                              overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(0.3)),
                              textStyle: MaterialStateProperty.all(TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ))
                          ),
                          child: Text(notSaved!=null && notSaved!? "Save & Discard" : "Discard"),
                        ),
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                )
            ),
            ),
        ],
      ),
    );
  }

  _saveVideoDetails(String filename, String path, Position location, String videolength) async {
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
    saveVideosList.add(SaveVideo(filename: filename, path: path, datetime: now, locationStr: locationStr, location: location, videoLength: videolength));
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

class VideoView extends StatefulWidget {
  const VideoView({Key? key, required this.path, required this.isCropped, this.notSaved, required}) : super(key: key);
  final String path;
  final bool isCropped;
  final bool? notSaved;

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {

  final secondaryColor = Color(0xFF8E92A8);
  final redColor = Color(0xFFFF6666);

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  final controller = Get.find<LodgeComplainController>();

  Subscription? _subscription;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    if(_subscription!=null) _subscription!.unsubscribe();
    super.dispose();
  }

  Future<void> initializePlayer() async {

    if(widget.isCropped || widget.notSaved==null){
      _videoPlayerController = VideoPlayerController.file(File(widget.path));
      controller.videoFile = File(widget.path);
    }else{
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
        controller.videoFile = compressedMediaInfo!.file!;
        _videoPlayerController = VideoPlayerController.file(compressedMediaInfo.file!);
      }catch (e){
        VideoCompress.cancelCompression();
        controller.videoFile = File(widget.path);
        _videoPlayerController = VideoPlayerController.file(controller.videoFile);
      }
    }

    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: false,
      autoInitialize: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: redColor,
        bufferedColor: secondaryColor,
        handleColor: redColor,
      ),
      placeholder: Container(color: Colors.black,)
    );
    controller.minutes = _videoPlayerController.value.duration.inMinutes;
    controller.seconds = _videoPlayerController.value.duration.inSeconds;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: _chewieController != null &&
          _chewieController!
              .videoPlayerController.value.isInitialized
          ? Chewie(
        controller: _chewieController!,
      )
          : CircularProgressIndicator(),
    );
  }
}
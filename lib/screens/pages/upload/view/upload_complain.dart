import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:etrafficcomplainer/screens/pages/upload/controller/upload_complain_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

//enum SingingCharacter { lafayette, jefferson }
class UploadComplain extends StatelessWidget {

  final controller = Get.put(UploadComplainController());
  final String path = "";
  LocationResult? location;

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
          position: LatLng(location!.latLng!.latitude, location!.latLng!.longitude),
      ),
    ].toSet();
  }




  @override
  Widget build(BuildContext context) {

    print("lodge complain screen is build!");
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle:  Text("Upload From Device",
          style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 18.0
          ),
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
            child: GetBuilder<UploadComplainController>(
              builder: (controller) {
                return SizedBox(
                  height: 140,
                  child: controller.videoFile==null? InkWell(
                    onTap: () async{
                      controller.getDeviceVideo();
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon( CupertinoIcons.circle_fill, color: hintTextColor.withOpacity(0.5), size: 110,),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(CupertinoIcons.square_arrow_up, color: secondaryColor, size: 48,),
                            Text("Import", style: TextStyle(
                                color: secondaryColor,
                                fontSize: 10
                            ),)
                          ],
                        )
                      ],
                    ),
                  ) :
                  VideoView(file: controller.videoFile!)
                  //child: VideoView(path: path, isCropped: true,)
                  );
              }
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: GetBuilder<UploadComplainController>(
                  builder: (controller) {
                    return Text(location==null? "Pick Location": "Information", style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: primaryColor
                    ),
                    );
                  }
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
                      GetBuilder<UploadComplainController>(
                        builder: (controller) {
                          return SizedBox(
                            height: 100,
                            child: location==null? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 110.0 , vertical: 32.0),
                              child: OutlinedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.location_solid, color: whiteColor, size: 19,),
                                    SizedBox(width: 3,),
                                    Text('Pick Location'),
                                  ],
                                ),
                                style: OutlinedButton.styleFrom(
                                  primary: whiteColor,
                                  backgroundColor: greenColor,
                                  side: BorderSide(color: whiteColor, width: 1),
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () async{
                                  FocusScope.of(context).unfocus();
                                  LocationResult? result = await showLocationPicker(
                                    context,"",
        //                            "",
//                      automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
                                    myLocationButtonEnabled: true,
                                    countries: ['lk']

//                      resultCardAlignment: Alignment.bottomCenter,
                                    desiredAccuracy: LocationAccuracy.best,
                                  );
                                  location = result;
                                  controller.getLocationAddress(location!);
                                },
                              ),
                            ) :
                            GoogleMap(
                                  liteModeEnabled: true,
                                  myLocationButtonEnabled: false,
                                  myLocationEnabled: false,
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(location!.latLng!.latitude, location!.latLng!.longitude),
                                    zoom: 15.4746,
                                  ),
                                  markers: _createMaker(),
                                  zoomControlsEnabled: true,
                                  zoomGesturesEnabled: true,
                                  onMapCreated: (GoogleMapController gmController) {
                                    _mapcontroller.complete(gmController);
                                  },
                            ),
                          );
                        }
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
                            GetBuilder<UploadComplainController>(
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
                      Container(
                        height: 50.0,
                        color: whiteColor,
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(CupertinoIcons.clock_fill, size: 19, color: greenColor,),
                            SizedBox(width: 16.0,),
                            Text("DateTime: ", style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            ),
                            GetBuilder<UploadComplainController>(
                                builder: (controller) {
                                  return Text("${controller.dateTime==null? controller.getFormattedDate(DateTime.now()): controller.getFormattedDate(controller.dateTime!)}", style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),);
                                }
                            ),
                            Spacer(),
                            InkWell(
                              onTap: (){
                                DatePicker.showDateTimePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime.now().add(-Duration(days: 30)),
                                    maxTime: DateTime.now(), onChanged: (date) {
                                      print('change $date');
                                    }, onConfirm: (date) {
                                      print('confirm $date');
                                      controller.setDateTime(date);
                                    }, currentTime: DateTime.now(),
                                );
                              },
                              child: Icon(CupertinoIcons.calendar, color: secondaryColor, size: 20,),
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
                        child: GetBuilder<UploadComplainController>(
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
                        child: GetBuilder<UploadComplainController>(
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
                            if(location!=null) controller.lodgeComplaint(location!);
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
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            controller.discardComplaint();
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
                          child: Text("Discard"),
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

}

class VideoView extends StatefulWidget {
  const VideoView({Key? key, required this.file}) : super(key: key);
  final File file;

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {

  final secondaryColor = Color(0xFF8E92A8);
  final redColor = Color(0xFFFF6666);

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  final controller = Get.find<UploadComplainController>();

  late final Subscription _subscription;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _subscription.unsubscribe();
    super.dispose();
  }

  Future<void> initializePlayer() async {

    _subscription =
        VideoCompress.compressProgress$.subscribe((progress) {
          EasyLoading.showProgress(progress/100, status: 'Compressing...');
        });

    try{
      await VideoCompress.setLogLevel(0);
      MediaInfo? compressedMediaInfo = await VideoCompress.compressVideo(
          widget.file.path,
          quality: VideoQuality.DefaultQuality,
          deleteOrigin: false,
          includeAudio: true // It's false by default
      );
      EasyLoading.dismiss();
      controller.videoFile = compressedMediaInfo!.file!;
      _videoPlayerController = VideoPlayerController.file(compressedMediaInfo.file!);
    }catch (e){
      VideoCompress.cancelCompression();
      controller.videoFile = widget.file;
      _videoPlayerController = VideoPlayerController.file(controller.videoFile!);
    }

    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      autoInitialize: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: redColor,
        bufferedColor: secondaryColor,
        handleColor: redColor,
      ),
      placeholder: Container(color: Colors.black,)
    );
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

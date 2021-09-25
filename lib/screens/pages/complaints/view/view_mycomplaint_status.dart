import 'package:chewie/chewie.dart';
import 'package:etrafficcomplainer/screens/pages/complaints/controller/complaint_status_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'dart:io';

class MyComplaintScreen extends StatelessWidget {

  final myComplaintStatusController = Get.find<ComplaintStatusController>();
  MyComplaintScreen() {
    myComplaintStatusController.getVideoPath();
  }

  final primaryColor = Color(0xFF414B70);
  final secondaryColor = Color(0xFF8E92A8);
  final whiteColor = Color(0xFFFFFFFF);
  final backgroundGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFEEEEEC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,);
  final borderEnableColor = Color(0xFFF6F6F6);
  final hintTextColor = Color(0xFFB2B5C4);
  final dropshadowColor = Color(0x1A4B4B4B);
  final redColor = Color(0xFFFF6666);
  final popupBarrierColor = Color(0xFF151929).withOpacity(0.4);

  @override
  Widget build(BuildContext context) {
    final myComplaintStatusController = Get.find<ComplaintStatusController>();
    // ignore: non_constant_identifier_names


    print("my complaint status build");
    return GetBuilder<ComplaintStatusController>(
        init: ComplaintStatusController(),
        builder: (controller) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                gradient: backgroundGradient,

              ),
              child: Scaffold(
                appBar: new AppBar(
                  backgroundColor: primaryColor,
                  toolbarHeight: 88,

                  centerTitle: true,
                  title: Column(
                    children: [
                      SizedBox(height: 30,),
                      Text("Track Status",
                        style: TextStyle(fontSize: 24, color: whiteColor),),
                    ],
                  ),
                ),
                backgroundColor: Colors.transparent,

                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Column(

                    children: [
                      Center(

                        child: Column(
                          children: [
                            Container(
                              child: Divider(
                                color: hintTextColor,
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Text("Attachement", style: TextStyle(
                                    fontSize: 15,
                                    color: primaryColor,

                                  ),),
                                ),
                                Container(
                                  child: Divider(
                                    color: hintTextColor,
                                  ),
                                ),
                                // Video view component is here
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(0.0),
                                  color: whiteColor,
                                  child: SizedBox(
                                      height: 140,
                                      child: controller.videoPath!=null? VideoView(file: File(controller.videoPath!),): SizedBox.shrink()
                                  ),
                                ),

                                SizedBox(height: 16,),

                              ],

                            ),

                          ],
                        ),
                      ),

                      Expanded(
                        child: CupertinoTabView(
                          builder: (context) {
                            return CupertinoPageScaffold(
                                child: getStatus(context));
                          },
                        ),
                      ),

                      Container(
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
                            Get.offNamed("/home");
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              backgroundColor: MaterialStateProperty.all(borderEnableColor),
                              foregroundColor: MaterialStateProperty.all(primaryColor),
                              textStyle: MaterialStateProperty.all(TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ))
                          ),


                          child: Text("Back"),

                        ),

                      ),
                    ],
                  ),


                ),

              ),
            ),
          );
        }

    );
  }

// void getPath() async{
//   final controller = Get.find<ComplaintStatusController>();
//   String? path = await controller.getVideoPath();
//
// }
  Widget getStatus(BuildContext context){
    final controller = Get.find<ComplaintStatusController>();
    // controller.getMyStatusList();
    print("1");
    // print(controller.myStatusList!.length);

    return Container(
      margin: new EdgeInsets.symmetric(horizontal: 10.0),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: backgroundGradient,
      ),

      child: controller.myStatusList != null? SingleChildScrollView(

        padding: EdgeInsets.only(top: 28.0),

        child: Column(

            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Container(


                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24,),

                    Row(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text("${controller.getPendingStatusDate()}" + "  ", style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: primaryColor),),

                          ],
                        ),

                        Container(
                          // color: primaryColor,
                          // height: 14,
                          // width: 1,

                          child: Icon(
                            CupertinoIcons.gobackward,
                            color: primaryColor,
                            size: 14.0,
                          ),
                        ),




                        Column(
                          children: [
                            Text("    "+"Complaint is pending.", style: TextStyle(fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: primaryColor),),
                          ],
                        ),

                      ],
                    )
                  ],
                ),

              ),
              Container(
                  child:Column(
                    children:controller.myStatusList!.map( (complaintStatus) => _statusViewComponent(context,complaintStatus.createdAt, complaintStatus.date, complaintStatus.getStatus(), complaintStatus.statusIcon)).toList(),
                  )
              )
            ]
        ),
      ):

      Container(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24,),

            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text("${controller.getPendingStatusDate()}" + "       ", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor),),

                  ],
                ),

                Container(

                  child: Icon(
                    CupertinoIcons.gobackward,
                    color: primaryColor,
                    size: 14.0,
                  ),
                  // color: primaryColor,
                  // height: 20,
                  // width: 1,
                ),
                SizedBox(width:10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text("    "+"Complaint is pending.", style: TextStyle(fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor),),
                  ],
                ),

              ],
            )
          ],
        ),

      ),

    );
    print("6");
  }

  Widget _statusViewComponent(BuildContext context, String? createdAt, String? date, String? status, IconData? statusIcon) {
    print("2");
    // final mycomplaintController = Get.find<ComplaintStatusController>();

    print("My complaint status build");
    return SafeArea(
      child: Container(
        margin: new EdgeInsets.symmetric(horizontal: 0.0),
        // height: 400,
        width: double.infinity,

        decoration: new BoxDecoration(
          // borderRadius: new BorderRadius.circular(16.0),
          color: whiteColor,
        ),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24,),

            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(date! + "      ", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor),),

                  ],
                ),
                Column(
                  children: [
                    Container(

                      child: Icon(
                        statusIcon,
                        color: primaryColor,
                        size: 14.0,
                      ),
                      // color: primaryColor,
                      // height: 20,
                      // width: 1,
                    ),
                  ],
                ),
                SizedBox(width: 10),


                Column(
                  children: [
                    Text("" +status!, style: TextStyle(fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor),),
                  ],
                ),

              ],
            )
          ],
        ),
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

  final controller = Get.find<ComplaintStatusController>();

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.file(widget.file);
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
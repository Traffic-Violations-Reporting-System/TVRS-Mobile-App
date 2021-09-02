
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:etrafficcomplainer/screens/pages/record/controller/record_controller.dart';
import 'package:etrafficcomplainer/screens/pages/record/view/VideoView.dart';
import 'package:etrafficcomplainer/screens/pages/record/view/lodge_complain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

late List<CameraDescription> cameras;

class RecordScreen extends StatefulWidget {
  RecordScreen({Key? key}) : super(key: key);

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool iscamerafront = true;
  double transform = 0;
  final controller = Get.put(RecordController());

  final redColor = Color(0xFFFF6666);
  final greenColor = Color(0xFF67C2C9);
  final secondaryColor = Color(0xFF8E92A8);
  final dropshadowColor = Color(0x1A4B4B4B);
  final primaryColor = Color(0xFF414B70);
  final whiteColor = Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.veryHigh);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
    controller.disposeRecording();
    print("RecordScreen is dispose!");
  }

  @override
  Widget build(BuildContext context) {
    print("Record Screen is Build!");
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.videocam_circle, color: primaryColor,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Icon(CupertinoIcons.chevron_right_2, color: secondaryColor, size: 10,),
            ),
            Icon(CupertinoIcons.crop, color: secondaryColor,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Icon(CupertinoIcons.chevron_right_2, color: secondaryColor, size: 10,),
            ),
            Icon(CupertinoIcons.cloud_upload, color: secondaryColor,),
          ],
        ),
      ),
      child: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(_cameraController));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0.0,
            child: Container(
              height: 108,
              color: primaryColor.withOpacity(0.7),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 4.0,),
                  Obx(()=>controller.isRecording.isTrue?
                  Text(
                      controller.time.value,
                      style: TextStyle(
                        color: whiteColor,
                      )
                  ) : SizedBox(height: 16,)
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 48,
                        icon: Obx(() => Icon(
                          controller.flash.isTrue ? CupertinoIcons.light_max : CupertinoIcons.light_min,
                          color: Colors.white,
                          size: 30,
                        )),
                        onPressed: () {
                          controller.flash.toggle();
                          controller.flash.isTrue
                              ? _cameraController
                              .setFlashMode(FlashMode.torch)
                              : _cameraController.setFlashMode(FlashMode.off);
                        }),
                      IconButton(
                          padding: EdgeInsets.all(0.0),
                          iconSize: 80,
                          icon: Obx(() => controller.isRecording.isTrue
                              ? Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.square_fill,
                                  color: redColor,
                                  size: 25,
                                ),
                                Icon(
                                  CupertinoIcons.circle,
                                  color: Colors.white,
                                ),
                              ]
                              )
                              : Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.circle_fill,
                                  color: Colors.white,
                                ),
                                Icon(
                                  CupertinoIcons.circle_fill,
                                  color: redColor,
                                  size: 25,
                                ),
                              ])
                          ),
                          onPressed: () async {
                            if(controller.isRecording.isFalse){
                              controller.isRecording.toggle();
                              await _cameraController.startVideoRecording();
                              controller.timer.start();
                              controller.determinePosition();
                            }else{
                              if(controller.complainLocation == null) return;
                              controller.isRecording.toggle();
                              controller.timer.pause();
                              XFile videopath = await _cameraController.stopVideoRecording();
                              print("video path is: "+videopath.path);
                              late final page;
                              //String convertedVideoPath;
                              if(controller.timer.tick > 10){
                                // convertedVideoPath = videopath.path.replaceAll(".mp4", "_converted.mp4");
                                // int result = await _flutterFFmpeg.execute("ffmpeg -i ${videopath.path} -vcodec mov -acodec libfaac $convertedVideoPath");
                                // print("converted_result: " + result.toString());
                                // return;
                                // convertedVideoPath = result == 0? convertedVideoPath : videopath.path;
                                page = VideoViewPage(
                                    file: File(videopath.path),
                                    location: controller.complainLocation!
                                );
                              }else{
                                page = LodgeComplain(
                                    file: File(videopath.path),
                                    location: controller.complainLocation!
                                );
                              }
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => page)
                              );
                            }
                          }),
                      Obx(() => controller.isRecording.isTrue? IconButton(
                          iconSize: 48,
                          icon: controller.isPaused.isTrue? Icon(
                            CupertinoIcons.play_circle,
                            color: Colors.white,
                          )
                              :
                          Icon(
                            CupertinoIcons.pause_circle,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            if(controller.isPaused.isFalse){
                              controller.timer.pause();
                              _cameraController.pauseVideoRecording();
                            }else{
                              controller.timer.start();
                              _cameraController.resumeVideoRecording();
                            }
                            controller.isPaused.toggle();
                          })
                          :
                          IconButton(
                            iconSize: 48,
                            icon: controller.isPaused.isTrue? Icon(
                              CupertinoIcons.camera_rotate_fill,
                              color: Colors.white,
                              size: 30,
                          )
                              :
                          Icon(
                            CupertinoIcons.camera_rotate,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () async {
                            // !controller.isPaused.isTrue? controller.timer.pause() : controller.timer.start();
                            // controller.isPaused.toggle();
                          })
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

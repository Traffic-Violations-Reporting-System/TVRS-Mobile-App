import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

late List<CameraDescription> cameras;

class RecordScreen extends StatefulWidget {
  RecordScreen({Key? key}) : super(key: key);

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool isRecoring = false;
  bool flash = false;
  bool iscamerafront = true;
  double transform = 0;

  final redColor = Color(0xFFFF6666);
  final greenColor = Color(0xFF67C2C9);
  final secondaryColor = Color(0xFF8E92A8);
  final dropshadowColor = Color(0x1A4B4B4B);
  final primaryColor = Color(0xFF414B70);
  final whiteColor = Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              color: primaryColor,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 4.0,),
                  Text("10:00", style: TextStyle(
                    color: whiteColor,
                  ),),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 48,
                        icon: Icon(
                          flash ? CupertinoIcons.light_max : CupertinoIcons.light_min,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            flash = !flash;
                          });
                          flash
                              ? _cameraController
                              .setFlashMode(FlashMode.torch)
                              : _cameraController.setFlashMode(FlashMode.off);
                        }),
                      IconButton(
                          padding: EdgeInsets.all(0.0),
                          iconSize: 80,
                          icon: isRecoring
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
                              ]
                            ),
                          onPressed: () async {
                            setState(() {
                              isRecoring = true;
                            });
                          }),
                      // GestureDetector(
                      //   onLongPress: () async {
                      //     await _cameraController.startVideoRecording();
                      //     setState(() {
                      //       isRecoring = true;
                      //     });
                      //   },
                      //   onLongPressUp: () async {
                      //     XFile videopath =
                      //     await _cameraController.stopVideoRecording();
                      //     setState(() {
                      //       isRecoring = false;
                      //     });
                      //     // Navigator.push(
                      //     //     context,
                      //     //     MaterialPageRoute(
                      //     //         builder: (builder) => VideoViewPage(
                      //     //               path: videopath.path,
                      //     //             )));
                      //   },
                      //   onTap: () {
                      //     if (!isRecoring) takePhoto(context);
                      //   },
                      //   child: isRecoring
                      //       ? Icon(
                      //     Icons.radio_button_on,
                      //     color: Colors.red,
                      //     size: 80,
                      //   )
                      //       : Icon(
                      //     Icons.panorama_fish_eye,
                      //     color: Colors.white,
                      //     size: 80,
                      //   ),
                      // ),
                      IconButton(
                          iconSize: 48,
                          icon: Icon(
                            CupertinoIcons.pause_circle,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            setState(() {
                              iscamerafront = !iscamerafront;
                              transform = transform + pi;
                            });
                            int cameraPos = iscamerafront ? 0 : 1;
                            _cameraController = CameraController(
                                cameras[cameraPos], ResolutionPreset.high);
                            cameraValue = _cameraController.initialize();
                          }),
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

  void takePhoto(BuildContext context) async {
    XFile file = await _cameraController.takePicture();
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (builder) => CameraViewPage(
    //               path: file.path,
    //             )));
  }
}

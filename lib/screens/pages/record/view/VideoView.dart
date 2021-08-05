import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_trimmer/video_trimmer.dart';

class VideoViewPage extends StatefulWidget {
  const VideoViewPage({Key? key, required this.file}) : super(key: key);
  final File file;

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

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  Future<String?> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    String? _value;

    await _trimmer
        .saveTrimmedVideo(startValue: _startValue, endValue: _endValue)
        .then((value) {
      setState(() {
        _progressVisibility = false;
        _value = value;
      });
    });

    return _value;
  }

  void _loadVideo() {
    _trimmer.loadVideo(videoFile: widget.file);
  }

  @override
  void initState() {
    super.initState();

    _loadVideo();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Icon(CupertinoIcons.chevron_right_2, color: secondaryColor, size: 10,),
            ),
            Icon(CupertinoIcons.cloud_upload, color: secondaryColor,),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 40,),
          Expanded(
            child: Stack(
                children: [
                  VideoViewer(trimmer: _trimmer),
                  Center(
                    child: IconButton(
                        padding: EdgeInsets.all(0.0),
                        iconSize: 35,
                        icon: _isPlaying? Icon(
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
                          bool playbackState = await _trimmer.videPlaybackControl(
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
            padding: EdgeInsets.only(bottom: 5.0),
            child: Center(
              child: TrimEditor(
                trimmer: _trimmer,
                showDuration: true,
                borderPaintColor: yellowColor,
                circlePaintColor: greenColor,
                scrubberPaintColor: greenColor,
                scrubberWidth: 1.5,
                viewerHeight: 50.0,
                viewerWidth: MediaQuery.of(context).size.width,
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
            padding: EdgeInsets.only(right: 24.0, left: 24.0, top: 8.0, bottom: 12.0),
            color: whiteColor,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: secondaryColor.withOpacity(0.3),
                    border: Border.all(color: secondaryColor)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text("You can upload only 1 minute video.\nTry to capture hottest minute of the video.", style: TextStyle(
                      color: secondaryColor,
                      fontSize: 14.0,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,),
                  ),
                ),
                SizedBox(height: 16.0,),
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
                    onPressed: (){
                      //otp2Controller.otpVerify(otpCodeController.text);
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        backgroundColor: MaterialStateProperty.all(redColor),
                        foregroundColor: MaterialStateProperty.all(whiteColor),
                        overlayColor: MaterialStateProperty.all(whiteColor.withOpacity(0.1)),
                        textStyle: MaterialStateProperty.all(TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text("Lodge Complain"),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 20.0),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/img/slide.png"),
                                fit: BoxFit.contain,
                                alignment: Alignment.center
                            ),
                          ),
                        ),
                      ],
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
}

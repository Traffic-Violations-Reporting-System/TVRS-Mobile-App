import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:etrafficcomplainer/screens/pages/record/controller/lodge_complain_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

//enum SingingCharacter { lafayette, jefferson }
class LodgeComplain extends StatelessWidget {

  final controller = Get.put(LodgeComplainController());
  LodgeComplain({required this.file});
  final File file;
  //SingingCharacter? _character = SingingCharacter.lafayette;

  final primaryColor = Color(0xFF414B70);
  final whiteColor = Color(0xFFFFFFFF);
  final backgroundColor = Color(0xFFF6F6F6);
  final secondaryColor = Color(0xFF8E92A8);
  final borderEnableColor = Color(0xFFF6F6F6);
  final hintTextColor = Color(0xFFB2B5C4);
  final dropshadowColor = Color(0x1A4B4B4B);
  final redColor = Color(0xFFFF6666);
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
              child: VideoView(file: file)
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
                      getTextFormField(hint: "Message", maxLines: 5, minLines: 5, controller: controller.descriptionController, validator: (value){
                        if(value!.isEmpty){
                          return "Required!";
                        }
                        else{
                          return null;
                        }
                      }),
                      Divider(color: dividerColor, height: 0.0,),
                      getTextFormField(hint: "location", controller: controller.locationController, validator: (value){
                        if(value!.isEmpty){
                          return "Required!";
                        }
                        else{
                          return null;
                        }
                      }),

                      SizedBox(height: 16),


                      // ListTile(
                      //
                      //   title: const Text('I am the victim',style: TextStyle(color: Color(0xFF414B70))),
                      //   leading: Radio<SingingCharacter>(
                      //     value: SingingCharacter.lafayette,
                      //     groupValue: _character,
                      //     onChanged: (SingingCharacter? value) {
                      //       setState(() {
                      //         _character = value;
                      //         print(_character);
                      //
                      //       });
                      //     },
                      //   ),
                      // ),
                      //
                      // ListTile(
                      //   title: const Text('I am only a complainant',style: TextStyle(color: Color(0xFF414B70)),),
                      //   leading: Radio<SingingCharacter>(
                      //     value: SingingCharacter.jefferson,
                      //     groupValue: _character,
                      //     onChanged: (SingingCharacter? value) {
                      //       setState(() {
                      //         _character = value;
                      //         print(_character);
                      //
                      //       });
                      //     },
                      //   ),
                      // ),
                      SizedBox(height: 40,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(

                            width: 120,
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
                                  controller.lodgeComplain();
                                },
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                                  backgroundColor: MaterialStateProperty.all(primaryColor),
                                  foregroundColor: MaterialStateProperty.all(whiteColor),

                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Icon(Icons.upload, size: 18),
                                      ),
                                      TextSpan(
                                        text: " Upload",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                          SizedBox(width: 20,),
                          Container(

                            width: 120,
                            height: 53,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  color: dropshadowColor,
                                  spreadRadius: 0,
                                  blurRadius: 50,
                                  offset: Offset(0, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextButton(
                                onPressed: () {
                                  controller.lodgeComplain();
                                },
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                                    backgroundColor: MaterialStateProperty.all(Colors.black),
                                    foregroundColor: MaterialStateProperty.all(whiteColor),
                                    textStyle: MaterialStateProperty.all(TextStyle(
                                      fontWeight: FontWeight.w500,

                                    ))
                                ),

                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Icon(Icons.download, size: 18),
                                      ),
                                      TextSpan(
                                        text: " Save",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 22),
                      FlatButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            controller.getLocation();
                          },
                          color: Colors.blue,
                          child: Text("Goto location page", style: TextStyle(color: Colors.white),)
                      )

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
import 'package:etrafficcomplainer/screens/pages/record/controller/lodge_complain_controller.dart';
import 'package:etrafficcomplainer/screens/pages/record/view/chewie_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoFormFieldWidget extends StatefulWidget {

  @override
  _VideoFormFieldWidgetState createState() => _VideoFormFieldWidgetState();
}

enum SingingCharacter { lafayette, jefferson }
class _VideoFormFieldWidgetState extends State<VideoFormFieldWidget> {
  SingingCharacter? _character = SingingCharacter.lafayette;
  final Controller = Get.find<LodgeComplainController>();
  final primaryColor = Color(0xFF414B70);
  final whiteColor = Color(0xFFFFFFFF);
  final backgroundGradient = LinearGradient(colors: [Colors.white, Color(0xFFEEEEEC)], begin: Alignment.topCenter, end: Alignment.bottomCenter,);
  final secondaryColor = Color(0xFF8E92A8);
  final borderEnableColor = Color(0xFFF6F6F6);
  final hintTextColor = Color(0xFFB2B5C4);
  final dropshadowColor = Color(0x1A4B4B4B);
  final redColor = Color(0xFFFF6666);


  Widget getTextFormField({required Icon iconName, required String hint, required TextEditingController controller, required Function validator, double paddingTop = 8.0}) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: TextFormField(
        style: TextStyle(fontSize: 18.0,),
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: redColor, width: 1.0),
            borderRadius: const BorderRadius.all(
              const Radius.circular(8.0),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: redColor, width: 1.0),
            borderRadius: const BorderRadius.all(
              const Radius.circular(8.0),
            ),
          ),
          errorStyle: TextStyle(color: redColor),
          contentPadding: EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 16.0),
          hintText: hint,
          hintStyle: TextStyle(color: hintTextColor, fontSize: 14.0),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 15), // add padding to adjust icon
            child: iconName,
          ),
            // icon: Icon(Icons.upload, size: 18)

        ),
        controller: controller,
        validator: (value) {
          return validator(value);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    print("login is build!");
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
          image: DecorationImage(
              image: AssetImage("assets/img/back_vec_1.png"),
              fit: BoxFit.contain,
              alignment: Alignment.topCenter
          ),
        ),

        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(height: 60,),
                Container(
                  height: 200,
                  child:ChewieListItem(
                    videoPlayerController: VideoPlayerController.network(
                        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
                    looping: true,
                  ),
                ),

                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: new Column(
                      children: [
                        Column(
                          children: [
                            Form(


                              key: Controller.lodgeComplainFormKey,
                              child: Column(
                                children: <Widget>[


                                  getTextFormField(iconName:Icon(CupertinoIcons.bars),hint: "description", controller: Controller.descriptionController, validator: (value){
                                    if(value!.isEmpty){
                                      return "Required!";
                                    }
                                    else{
                                      return null;
                                    }
                                  }),
                                  getTextFormField(iconName:Icon(CupertinoIcons.location),hint: "location", controller: Controller.locationController, validator: (value){
                                    if(value!.isEmpty){
                                      return "Required!";
                                    }
                                    else{
                                      return null;
                                    }
                                  },paddingTop:16.0),

                                  SizedBox(height: 16),


                                  ListTile(

                                    title: const Text('I am the victim',style: TextStyle(color: Color(0xFF414B70))),
                                    leading: Radio<SingingCharacter>(
                                      value: SingingCharacter.lafayette,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                          print(_character);

                                        });
                                      },
                                    ),
                                  ),

                                  ListTile(
                                    title: const Text('I am only a complainant',style: TextStyle(color: Color(0xFF414B70)),),
                                    leading: Radio<SingingCharacter>(
                                      value: SingingCharacter.jefferson,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                          print(_character);

                                        });
                                      },
                                    ),
                                  ),
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
                                            Controller.lodgeComplain();
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
                                            Controller.lodgeComplain();
                                          },
                                          style: ButtonStyle(
                                              elevation: MaterialStateProperty.all(0),
                                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                                              backgroundColor: MaterialStateProperty.all(secondaryColor),
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
                                        Controller.getLocation();
                                      },
                                      color: Colors.blue,
                                      child: Text("Goto location page", style: TextStyle(color: Colors.white),)
                                  )

                                ],

                              ),

                            ),
                          ],
                        ),

                      ],

                    ),

                  ),

                ),
              ],
            ),
          ),
        ),

      ),
    );
  }

}












// class LodgeComplainScreen extends GetView<LodgeComplainController> {


// }
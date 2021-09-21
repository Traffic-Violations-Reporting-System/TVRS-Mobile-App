import 'package:etrafficcomplainer/screens/pages/settings/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends GetView<SettingsController> {

  final primaryColor = Color(0xFF414B70);
  final whiteColor = Color(0xFFFFFFFF);
  final backgroundColor = Color(0xFFF6F6F6);
  final backgroundGradient = LinearGradient(colors: [Colors.white, Color(0xFFEEEEEC)], begin: Alignment.topCenter, end: Alignment.bottomCenter,);
  final secondaryColor = Color(0xFF8E92A8);
  final borderEnableColor = Color(0xFFF6F6F6);
  final hintTextColor = Color(0xFFB2B5C4);
  final dropshadowColor = Color(0x1A4B4B4B);
  final redColor = Color(0xFFFF6666);
  final yellowColor = Color(0xFFFFBE15);
  final greenColor = Color(0xFF67C2C9);
  final dropshadowColor2 = Color(0xFF4B4B4B).withOpacity(0.15);

  @override
  Widget build(BuildContext context) {

    print("Settings is build!");
    return SafeArea(
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: backgroundGradient,
              image: DecorationImage(

                  image: AssetImage("assets/img/back_vec_1.png"),
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,top: 70,right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Settings",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontSize: 22,
                              ),
                            ),

                          ],
                        ),
                        
                        SizedBox(height: 20,),
                        SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Column(
                              children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 16, top: 24,bottom: 10),
                                    child:Text("Notifications",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                      fontSize: 14,
                                    ),),
                                  ),

                                  Container(
                                    child: Notification()
                                  )
                                ],
                              ),
                                Container(
                                  child: Divider(
                                    color: hintTextColor,
                                  ),
                                ),
                                
                                Theme(
                                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                  child:ExpansionTile(
                                    title: Flexible(
                                      child: Text("Privacy Policy",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                        fontSize: 14,
                                      ),),
                                    ),
                                    children: <Widget>[
                                      ListTile(
                                        title: Scrollbar(
                                          child: RichText(
                                            text: TextSpan(
                                              text: '',
                                              style: DefaultTextStyle.of(context).style,
                                              children: const <TextSpan>[
                                                TextSpan(text: 'Definitions \n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Color(0xFF414B70),)),
                                                TextSpan(text: '\n'),
                                                TextSpan(text: 'APPLICABLE MOBILE APPLICATION: \n', style: TextStyle(fontSize: 15,color: Color(0xFF414B70),)),
                                                TextSpan(text: 'This Privacy Policy will refer to and be applicable to the Mobile App listed above, which shall thereafter be referred to as "Mobile App."',style: TextStyle(fontSize: 15,color: Color(0xFF414B70),)),
                                                TextSpan(text: '\n'),
                                                TextSpan(text: '\n'),
                                                TextSpan(text: 'EFFECTIVE DATE: \n', style: TextStyle(fontSize: 15,color: Color(0xFF414B70),)),
                                                TextSpan(text: '"Effective Date" means the date this Privacy Policy comes into force and effect.',style: TextStyle(fontSize: 15,color: Color(0xFF414B70),)),
                                                TextSpan(text: '\n'),
                                                TextSpan(text: '\n'),
                                              ],
                                            ),
                                          ),
                                        )
                                      )
                                    ],

                                  ),
                                ),
                                Container(
                                  child: Divider(
                                    color: hintTextColor,
                                  ),
                                ),

                                Theme(
                                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                  child:ExpansionTile(
                                    title: Flexible(
                                      child: Text("About Us",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                        fontSize: 14,
                                      ),),
                                    ),
                                    children: <Widget>[

                                      ListTile(
                                          title: Scrollbar(
                                            child: RichText(
                                              text: TextSpan(
                                                text: '',
                                                style: DefaultTextStyle.of(context).style,
                                                children: const <TextSpan>[
                                                  TextSpan(text: '\n'),
                                                  TextSpan(text: 'The Party responsible for the processing of your personal data is as follows: Sri Lanka Police. The Data Controller may be contacted as follows:',style: TextStyle(fontSize: 15,color: Color(0xFF414B70),)),
                                                  TextSpan(text: '\n'),
                                                  TextSpan(text: '\n'),
                                                  TextSpan(text: 'etrafficcomplainer@gmail.com\n',style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green,
                                                    fontSize: 14,
                                                  )),
                                                  TextSpan(text: 'Contact - 041-2223334\n',style: TextStyle(fontSize: 15,color: Color(0xFF414B70),)),
                                                  TextSpan(text: '\n'),
                                                ],
                                              ),
                                            ),
                                          )
                                      )
                                    ],

                                  ),
                                ),


                            ]
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
        )
    );
  }
}

class Notification extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  final primaryColor = Color(0xFF414B70);
  final whiteColor = Color(0xFFFFFFFF);
  final backgroundColor = Color(0xFFF6F6F6);
  final backgroundGradient = LinearGradient(colors: [Colors.white, Color(0xFFEEEEEC)], begin: Alignment.topCenter, end: Alignment.bottomCenter,);
  final secondaryColor = Color(0xFF8E92A8);
  final borderEnableColor = Color(0xFFF6F6F6);
  final hintTextColor = Color(0xFFB2B5C4);
  final dropshadowColor = Color(0x1A4B4B4B);
  final redColor = Color(0xFFFF6666);
  final yellowColor = Color(0xFFFFBE15);
  final greenColor = Color(0xFF67C2C9);
  final dropshadowColor2 = Color(0xFF4B4B4B).withOpacity(0.15);
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: Switch(
          value: isSwitched,
          onChanged: (value){
            setState(() {
              isSwitched=value;
              print(isSwitched);
            });
          },
          activeTrackColor: backgroundColor,
          activeColor: primaryColor,
        ),
      );

  }
}


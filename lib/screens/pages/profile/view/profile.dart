
import 'package:etrafficcomplainer/screens/pages/profile/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {

  final primaryColor = Color(0xFF414B70);
  final whiteColor = Color(0xFFFFFFFF);
  final backgroundColor = Color(0xFFF6F6F6);
  final backgroundGradient = LinearGradient(colors: [Colors.white, Color(0xFFEEEEEC)], begin: Alignment.topCenter, end: Alignment.bottomCenter,);
  final secondaryColor = Color(0xFF8E92A8);
  final borderEnableColor = Color(0xFFF6F6F6);
  final hintTextColor = Color(0xFFB2B5C4);
  final dropshadowColor = Color(0x1A4B4B4B);
  final dropshadowColor2 = Color(0xFF4B4B4B).withOpacity(0.15);
  final redColor = Color(0xFFFF6666);
  final greenColor = Color(0xFF67C2C9);

  @override
  Widget build(BuildContext context) {
    print("Profile is build!");
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24.0,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: dropshadowColor2,
                      spreadRadius: 0,
                      blurRadius: 25,
                      offset: Offset(0, 6), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 48.0,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 48.0,
                            height: 48.0,
                            child: Image.asset('assets/img/map.png'),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Complain No: ", style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    ),
                                    SizedBox(height: 4.0,),
                                    Text("Account ID: ", style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 4.0,),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("23456789", style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    ),
                                    SizedBox(height: 4.0,),
                                    Text("980750736V", style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text("26 Aug", style: TextStyle(
                                color: secondaryColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400
                              ),),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 14.0,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      width: MediaQuery.of(context).size.width,
                      height: 23.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: greenColor, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: whiteColor,
                      ),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.square_list, color: greenColor, size: 15.0,),
                          SizedBox(width: 8.0,),
                          Text("Police Agent Assigned Your Complaint.", style: TextStyle(
                            color: greenColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            height: 33,
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

                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                  backgroundColor: MaterialStateProperty.all(whiteColor),
                                  foregroundColor: MaterialStateProperty.all(primaryColor),
                                  overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(0.3)),
                                  textStyle: MaterialStateProperty.all(TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ))
                              ),
                              child: Text("Withdraw")
                            ),
                          ),
                        ),
                        SizedBox(width: 6.0,),
                        Expanded(
                          child: Container(
                            height: 33,
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

                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                  backgroundColor: MaterialStateProperty.all(whiteColor),
                                  foregroundColor: MaterialStateProperty.all(primaryColor),
                                  overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(0.3)),
                                  textStyle: MaterialStateProperty.all(TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ))
                              ),
                              child: Text("LiveTrack")
                            ),
                          ),
                        ),
                        SizedBox(width: 6.0,),
                        Expanded(
                          child: Container(
                            height: 33,
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

                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                  backgroundColor: MaterialStateProperty.all(whiteColor),
                                  foregroundColor: MaterialStateProperty.all(primaryColor),
                                  overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(0.3)),
                                  textStyle: MaterialStateProperty.all(TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ))
                              ),
                              child: Text("Delete")
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ),
              SizedBox(height: 16.0,),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  width: double.infinity,
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: dropshadowColor2,
                        spreadRadius: 0,
                        blurRadius: 25,
                        offset: Offset(0, 6), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 48.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 48.0,
                              height: 48.0,
                              child: Image.asset('assets/img/map.png'),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Complain No: ", style: TextStyle(
                                        color: secondaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      ),
                                      SizedBox(height: 4.0,),
                                      Text("Account ID: ", style: TextStyle(
                                        color: secondaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 4.0,),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("23456789", style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      ),
                                      SizedBox(height: 4.0,),
                                      Text("980750736V", style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text("26 Aug", style: TextStyle(
                                    color: secondaryColor,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400
                                ),),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 14.0,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        width: MediaQuery.of(context).size.width,
                        height: 23.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: greenColor, width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: whiteColor,
                        ),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.square_list, color: greenColor, size: 15.0,),
                            SizedBox(width: 8.0,),
                            Text("Police Agent Assigned Your Complaint.", style: TextStyle(
                              color: greenColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              height: 33,
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

                                  },
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                      backgroundColor: MaterialStateProperty.all(whiteColor),
                                      foregroundColor: MaterialStateProperty.all(primaryColor),
                                      overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(0.3)),
                                      textStyle: MaterialStateProperty.all(TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ))
                                  ),
                                  child: Text("Withdraw")
                              ),
                            ),
                          ),
                          SizedBox(width: 6.0,),
                          Expanded(
                            child: Container(
                              height: 33,
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

                                  },
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                      backgroundColor: MaterialStateProperty.all(whiteColor),
                                      foregroundColor: MaterialStateProperty.all(primaryColor),
                                      overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(0.3)),
                                      textStyle: MaterialStateProperty.all(TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ))
                                  ),
                                  child: Text("LiveTrack")
                              ),
                            ),
                          ),
                          SizedBox(width: 6.0,),
                          Expanded(
                            child: Container(
                              height: 33,
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

                                  },
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                      backgroundColor: MaterialStateProperty.all(whiteColor),
                                      foregroundColor: MaterialStateProperty.all(primaryColor),
                                      overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(0.3)),
                                      textStyle: MaterialStateProperty.all(TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ))
                                  ),
                                  child: Text("Delete")
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
              ),
            ],
          ),
        ),
      );
  }
}
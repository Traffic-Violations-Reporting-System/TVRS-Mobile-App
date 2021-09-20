import 'package:etrafficcomplainer/screens/pages/profile/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget{
  final profileDataController = Get.put(ProfileDataController());
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
    final controller = Get.find<ProfileDataController>();

    print(controller.userProfile);
    print("Profile is build!");
    return SafeArea(
      child: Container(
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

        child: SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children :[
                  Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25,top: 70),
                    child: Column(
                      children: [
                        Text("My Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(height: 20,),

                      ],
                    ),
                  ),
                ),

                Container(

                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  margin: EdgeInsets.only(left: 25,right: 25),
                  height: 300,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Name Container
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 14,bottom: 10,right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text("Name",
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                            ),
                          ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${controller.userProfile!.userName}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                  ),
                                ),
                                // SizedBox(width: 104,),
                                Text("Update",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),

                          ]
                        ),
                      ),
                      //devider to seperate containers
                      Container(
                        child: Divider(
                          color: hintTextColor,
                        ),
                      ),

                      // Password Container
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 12,bottom: 10,right: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text("Password",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("********",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                    ),
                                  ),

                                  Text("Update",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),

                            ]
                        ),
                      ),
                      //devider to seperate containers
                      Container(
                        child: Divider(
                          color: hintTextColor,
                        ),
                      ),

                      //Phone number Container
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 12,bottom: 10,right: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text("Phone",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${controller.userProfile!.phone}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                    ),
                                  ),

                                  Text("Update",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),

                            ]
                        ),
                      ),

                      //devider to seperate containers
                      Container(
                        child: Divider(
                          color: hintTextColor,
                        ),
                      ),

                      //Police devision Container
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 12,bottom: 10,right: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text("Police Devision",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${controller.userProfile!.policeDevision}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                    ),
                                  ),

                                  Text("Update",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),

                            ]
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                //Bank details container
                Container(

                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  margin: EdgeInsets.only(left: 25,right: 25),
                  height: 100,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Name Container
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 14,bottom: 10,right: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text("Bank Information",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("BOC Ending With 4542",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 15,
                                    ),
                                  ),

                                  Text("Update",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 10,),
                              Text("Preferred For Payouts",
                                style: TextStyle(
                                  color: greenColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ]
                        ),
                      ),


                    ],
                  ),
                ),
                SizedBox(height: 30,),

                Container(
                  margin: EdgeInsets.only(left: 25, top: 14,bottom: 10,right: 25),
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
                      Get.offNamed("/add_payout_option");
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
                    child: Text("Add Another Account"),
                  ),
                ),

              ]

            ),

        ),

      ),
    );
  }

}
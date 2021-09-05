import 'package:etrafficcomplainer/screens/pages/complaints/controller/complaint_status_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class MyComplaintScreen extends StatelessWidget{


  final myComplaintController = Get.find<ComplaintStatusController>();
  final primaryColor = Color(0xFF414B70);
  final secondaryColor = Color(0xFF8E92A8);
  final whiteColor = Color(0xFFFFFFFF);
  final backgroundGradient = LinearGradient(colors: [Colors.white, Color(0xFFEEEEEC)], begin: Alignment.topCenter, end: Alignment.bottomCenter,);
  final borderEnableColor = Color(0xFFF6F6F6);
  final hintTextColor = Color(0xFFB2B5C4);
  final dropshadowColor = Color(0x1A4B4B4B);
  final redColor = Color(0xFFFF6666);
  final popupBarrierColor = Color(0xFF151929).withOpacity(0.4);

  @override
  Widget build(BuildContext context) {
    print("my complaint status build");
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
                Text("Track Status",style: TextStyle(fontSize: 24 ,color: whiteColor),),

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

                    SizedBox(height: 12,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(16.0),
                              color: whiteColor,

                            ),

                            child:Text("Complaint ID : ",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  // fontWeight: FontWeight.w500,
                                  color: secondaryColor,
                                )
                            ) ,

                          ),

                          Text("${myComplaintController.getComplaintID()}",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor,
                                  )
                              ),

                        ],
                    ),
                    Divider( color: secondaryColor,),
                    Text("${myComplaintController.getPoliceDevision()}",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                      // backgroundColor: Colors.green
                    ),
                    ),

                    SizedBox(height: 10,),
                    Text("${myComplaintController.getFullName()}",
                      style: TextStyle(
                        fontSize: 14.0,
                        // fontWeight: FontWeight.w500,
                        color: secondaryColor,
                        // backgroundColor: Colors.green
                      ),
                    ),
                    Divider( color: secondaryColor,),

                    Text("${myComplaintController.getLocation()}",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                          // backgroundColor: Colors.blue
                      ),
                    ),
                    SizedBox(height: 16,),
                    Column(
                      children: [

                    Container(
                        child: GridView.count(
                        crossAxisCount: 1,
                          childAspectRatio: 2/1,
                          shrinkWrap: true,
                          children: List.generate(1, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: backgroundGradient,
                                  image: DecorationImage(
                                    image: AssetImage("assets/img/locationImg.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0),),
                                  border: Border.all(color: borderEnableColor),
                                ),
                              ),
                            );
                          },),
                        ),
                      ),
                        SizedBox(height: 16,),

                      ],

                    ),

                  ],
                ),
              ),
                Column(
                  children: [
                    MyComplaintStatus(),
                  ],
                ),

              ]
            ),


          ),

        ),
      ),
    );
  }
}



class MyComplaintStatus extends StatefulWidget {
  @override
  _MyComplaintStatusState createState() => _MyComplaintStatusState();
}
class _MyComplaintStatusState extends State<MyComplaintStatus> {

  DateTime now = DateTime.now();

  final primaryColor = Color(0xFF414B70);
  final secondaryColor = Color(0xFF8E92A8);
  final whiteColor = Color(0xFFFFFFFF);
  final backgroundGradient = LinearGradient(colors: [Colors.white, Color(0xFFEEEEEC)], begin: Alignment.topCenter, end: Alignment.bottomCenter,);
  final borderEnableColor = Color(0xFFF6F6F6);
  final hintTextColor = Color(0xFFB2B5C4);
  final dropshadowColor = Color(0x1A4B4B4B);
  final redColor = Color(0xFFFF6666);
  final popupBarrierColor = Color(0xFF151929).withOpacity(0.4);

  @override
  Widget build(BuildContext context) {
    final mycomplaintController = Get.find<ComplaintStatusController>();
    final myList = mycomplaintController.getStatusArray();

    print("My complaint status build");
    return SafeArea(
      child: Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(16.0),
          color: whiteColor,
        ),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24,),
            for(int i=0; i<4; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                       Text("kasun"+"       ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500,color: primaryColor),),
                      // Text(myList[i]["time"]+"       ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500,color: primaryColor),),
                      // Text("\n"),
                    ],
                  ),
                  Column(
                    children: [
                      if(i==0)
                      Icon(Icons.download, size: 24),
                      if(i==1)
                        Icon(Icons.check, size: 24),
                      if(i==2)
                        Icon(Icons.email, size: 24),
                      if(i==3)
                        Icon(Icons.upload, size: 24),
                      if(i<5-1)
                      Container(
                        color: primaryColor,
                        height: 30,
                        width: 1,
                      ),
                    ],
                  ),


                  Column(
                    children: [
                    // Text(" "+myList[i]["status"], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: primaryColor),),
                      Text(" "+"lakshitha", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: primaryColor),),

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


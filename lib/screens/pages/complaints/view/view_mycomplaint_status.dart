import 'package:etrafficcomplainer/screens/pages/complaints/controller/complaint_status_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class MyComplaintScreen extends StatelessWidget {


  final myComplaintStatusController = Get.find<ComplaintStatusController>();

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
    // myComplaintStatusController.getMyStatusList();


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

                              SizedBox(height: 12,),

                              SizedBox(height: 16,),
                              Column(
                                children: [

                                  Container(
                                    margin: new EdgeInsets.symmetric(horizontal: 10.0),
                                    child: GridView.count(
                                      crossAxisCount: 1,
                                      childAspectRatio: 2 / 1,
                                      shrinkWrap: true,
                                      children: List.generate(1, (index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: backgroundGradient,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/img/locationImg.jpg"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                              BorderRadius.all(
                                                Radius.circular(10.0),),
                                              border: Border.all(
                                                  color: borderEnableColor),
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


                            child: Text("Back To Home"),

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
                          Text("${controller.getPendingStatusDate()}" + "     ", style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: primaryColor),),

                        ],
                      ),

                      Container(
                        color: primaryColor,
                        height: 14,
                        width: 1,
                      ),


                      Column(
                        children: [
                          Text("      " +"Pending", style: TextStyle(fontSize: 14,
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
                    Text("${controller.getPendingStatusDate()}" + "     ", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor),),

                  ],
                ),

                Container(
                  color: primaryColor,
                  height: 14,
                  width: 1,

                ),


                Column(
                  children: [
                    Text("      " +"Pending", style: TextStyle(fontSize: 14,
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
                      Text(date! + "     ", style: TextStyle(
                          fontSize: 10,
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


                  Column(
                    children: [
                      Text("   " +status!, style: TextStyle(fontSize: 10,
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





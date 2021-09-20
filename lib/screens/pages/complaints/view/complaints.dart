
import 'package:etrafficcomplainer/screens/pages/complaints/controller/complaints_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;
import 'package:marquee/marquee.dart';

class ComplaintsScreen extends StatelessWidget {

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

  //final complaintController = Get.put(ComplaintsController());

  @override
  Widget build(BuildContext complaintContext) {
    print("Complaints is build!");
    return GetBuilder<ComplaintsController>(
        init: ComplaintsController(),
        builder: (controller) {
          return SafeArea(
            child: CupertinoPageScaffold(
              backgroundColor: backgroundColor,
              navigationBar: CupertinoNavigationBar(
                  automaticallyImplyLeading: false,
                  middle: Text("My Complaints",
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0
                    ),
                  )
              ),
              child: SizedBox(
                width: MediaQuery.of(complaintContext).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 44,),
                    CupertinoTabBar.CupertinoTabBar(
                      Colors.transparent,
                      primaryColor,
                      [
                        Text(
                          "Active",
                          style: TextStyle(
                            color: controller.pageIndex == 0? whiteColor : secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Saved",
                          style: TextStyle(
                            color: controller.pageIndex == 1? whiteColor : secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                      controller.getPageIndex,
                      controller.changePageIndex,
                      useShadow: false,
                      allowExpand: true,
                      borderRadius: const BorderRadius.all(
                          const Radius.circular(8.0)),
                    ),
                    SizedBox(
                      height: 23,
                      child: TextButton(
                        onPressed: () {
                          controller.tapToRefresh();
                        },
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                            backgroundColor: MaterialStateProperty.all(yellowColor),
                            overlayColor: MaterialStateProperty.all(whiteColor.withOpacity(0.3)),
                            padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.refresh_thick, color: whiteColor, size: 15,),
                            SizedBox(width: 5.0,),
                            Text("Tap to Refresh!", style: TextStyle(
                                color: whiteColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600
                            ),
                              textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: CupertinoTabView(
                        builder: (context) {
                          return controller.pageIndex == 0? CupertinoPageScaffold( child: _activeComplaints(complaintContext)) : CupertinoPageScaffold( child: _savedComplaints(complaintContext));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
    }
    );
  }

  Widget _activeComplaints(BuildContext context){
    final controller = Get.find<ComplaintsController>();
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: controller.myComplainList != null? SingleChildScrollView(
        padding: EdgeInsets.only(top: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: controller.myComplainList!.map( (complaint) => _complainViewComponent(context, complaint.createdAt, complaint.complainID, complaint.userID, complaint.getStatus())).toList(),
        ),
      ):
      Center(
        child: Text("You don't have any complaints yet.", style: TextStyle(
          color: secondaryColor,
          fontSize: 12.0,
          fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }

  Widget _complainViewComponent(BuildContext context, String? createdAt, String? complainID, String? userID, String status){
    final controller = Get.find<ComplaintsController>();
    return Container(
        margin: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16.0),
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
                            Text(complainID ?? "Error", style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            ),
                            SizedBox(height: 4.0,),
                            Text(userID ?? "Error", style: TextStyle(
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
                      child: Text(createdAt ?? "Error", style: TextStyle(
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
                  Text(status, style: TextStyle(
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
                        onPressed: () {

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
                          if(complainID!=null) controller.saveHideComplaintsList(complainID);
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
                        child: Text("Hide")
                    ),
                  ),
                ),
              ],
            )
          ],
        )
    );
  }

  Widget _savedComplaints(BuildContext context){
    final controller = Get.find<ComplaintsController>();
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: controller.mySavedVideosList != null? SingleChildScrollView(
        padding: EdgeInsets.only(top: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: controller.mySavedVideosList!.map( (savedComplaint) => _savedViewComponent(context, savedComplaint.filename, savedComplaint.datetime, savedComplaint.locationStr, savedComplaint.path, savedComplaint.location, savedComplaint.videoLength)).toList(),
        ),
      ):
      Center(
        child: Text("You don't have any saved complaints yet.", style: TextStyle(
            color: secondaryColor,
            fontSize: 12.0,
            fontWeight: FontWeight.w500
        ),
        ),
      ),
    );
  }

  Widget _savedViewComponent(BuildContext context, String? filename, String? datetime, String? locationStr, String? path, Position? location, String videolength){
    final controller = Get.find<ComplaintsController>();
    return Container(
        margin: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        width: double.infinity,
        height: 194,
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
              height: 72.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("File Name: ", style: TextStyle(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      ),
                      SizedBox(height: 4.0,),
                      Text("Saved Date: ", style: TextStyle(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      ),
                      SizedBox(height: 4.0,),
                      Text("Video length: ", style: TextStyle(
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
                      Text(filename ?? "Error", style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      ),
                      SizedBox(height: 4.0,),
                      Text(datetime ?? "Error", style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      ),
                      SizedBox(height: 4.0,),
                      Text(videolength, style: TextStyle(
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
                  Icon(CupertinoIcons.location, color: greenColor, size: 15.0,),
                  SizedBox(width: 8.0,),
                  GetBuilder<ComplaintsController>(
                      builder: (controller) {
                        return Flexible(
                          child: controller.mySavedVideosList==null? Text("loading...", style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),) :
                          Marquee(
                            text: "$locationStr",
                            style: TextStyle(
                              color: greenColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            blankSpace: 40.0,
                            velocity: 50.0,
                            startAfter: Duration(seconds: 2),
                            pauseAfterRound: Duration(seconds: 2),
                            numberOfRounds: 4,
                          ),
                        );
                      }
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
                        onPressed: () {
                          if(path != null && location != null)controller.lodgeComplaint(context, path, location, videolength);
                        },
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                            backgroundColor: MaterialStateProperty.all(whiteColor),
                            foregroundColor: MaterialStateProperty.all(primaryColor),
                            overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(0.3)),
                            textStyle: MaterialStateProperty.all(TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ))
                        ),
                        child: Text("Lodge Complaint")
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
                            padding: MaterialStateProperty.all(EdgeInsets.all(0)),
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
    );
  }

}

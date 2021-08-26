import 'package:etrafficcomplainer/screens/pages/complaints/controller/complaints_controller.dart';
import 'package:etrafficcomplainer/screens/pages/profile/view/profile.dart';
import 'package:etrafficcomplainer/screens/pages/settings/view/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;

class ComplaintsScreen extends StatelessWidget {

  final primaryColor = Color(0xFF414B70);
  final whiteColor = Color(0xFFFFFFFF);
  final backgroundColor = Color(0xFFF6F6F6);
  final secondaryColor = Color(0xFF8E92A8);
  final borderEnableColor = Color(0xFFF6F6F6);
  final hintTextColor = Color(0xFFB2B5C4);
  final dropshadowColor = Color(0x1A4B4B4B);
  final redColor = Color(0xFFFF6666);
  final yellowColor = Color(0xFFFFBE15);

  final pages = [
    ProfileScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
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
                width: MediaQuery.of(context).size.width,
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
                    Container(
                      height: 23,
                      color: yellowColor,
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
                    Expanded(
                      child: CupertinoTabView(
                        builder: (context) {
                          return CupertinoPageScaffold(
                              child: pages[controller.pageIndex]);
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
}
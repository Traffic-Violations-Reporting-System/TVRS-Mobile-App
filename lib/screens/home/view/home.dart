import 'package:etrafficcomplainer/screens/pages/complaints/view/complaints.dart';
import 'package:etrafficcomplainer/screens/pages/profile/view/profile.dart';
import 'package:etrafficcomplainer/screens/pages/record/view/record.dart';
import 'package:etrafficcomplainer/screens/pages/settings/view/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:etrafficcomplainer/screens/home/controller/home_controller.dart';
import 'package:etrafficcomplainer/services/api_service.dart';

class HomeScreen extends StatelessWidget {

  final redColor = Color(0xFFFF6666);
  final greenColor = Color(0xFF67C2C9);
  final secondaryColor = Color(0xFF8E92A8);
  final dropshadowColor = Color(0x1A4B4B4B);
  final primaryColor = Color(0xFF414B70);
  final whiteColor = Color(0xFFFFFFFF);

  final pages = [
    RecordScreen(),
    ComplaintsScreen(),
    ProfileScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) {
          return SafeArea(
            child: CupertinoTabScaffold(
              tabBar: CupertinoTabBar(
                backgroundColor: whiteColor,
                activeColor: primaryColor,
                inactiveColor: secondaryColor,
                currentIndex: controller.pageIndex,
                onTap: controller.changePageIndex,
                items: [
                        BottomNavigationBarItem(
                            icon: controller.pageIndex==0? Icon(CupertinoIcons.videocam_circle_fill) : Icon(CupertinoIcons.videocam_circle),
                            label: "Record"
                        ),
                        BottomNavigationBarItem(
                            icon: controller.pageIndex==1? Icon(CupertinoIcons.exclamationmark_octagon_fill) : Icon(CupertinoIcons.exclamationmark_octagon),
                            label: "Complaints"
                        ),
                        BottomNavigationBarItem(
                            icon: controller.pageIndex==2? Icon(CupertinoIcons.person_crop_circle_fill) : Icon(CupertinoIcons.person_crop_circle),
                            label: "My Profile"
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(CupertinoIcons.settings),
                            label: "Settings"
                        ),
                ],
              ),
              tabBuilder: (BuildContext context, int index) {
                    return CupertinoTabView(
                      builder: (context){
                        return CupertinoPageScaffold(child: pages[index]);
                      },
                    );
              },
            ),
          );
        },);
  }
}

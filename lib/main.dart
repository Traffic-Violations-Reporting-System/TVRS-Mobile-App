import 'package:etrafficcomplainer/screens/otp_verify/binding/otp_verify_binding.dart';
import 'package:etrafficcomplainer/screens/otp_verify/view/otp_verify.dart';
import 'package:etrafficcomplainer/screens/otp_verify_2/binding/otp_verify_2_binding.dart';
import 'package:etrafficcomplainer/screens/otp_verify_2/view/otp_verify_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:etrafficcomplainer/screens/home/binding/home_binding.dart';
import 'package:etrafficcomplainer/screens/home/view/home.dart';
import 'package:etrafficcomplainer/screens/register/binding/register_binding.dart';
import 'package:etrafficcomplainer/screens/register/view/register.dart';

void main() {
  runApp(MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.native,
      title: 'e Traffic Complainer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      getPages: [
        GetPage(name: "/home", page: ()=>HomeScreen(), binding: HomeBinding()),
        GetPage(name: "/register", page: ()=>RegisterScreen(), binding: RegisterBinding()),
        GetPage(name: "/otp_verify", page: ()=>OTPVerifyScreen(), binding: OTPVerifyBinding()),
        GetPage(name: "/otp_verify_2", page: ()=>OTPVerify2Screen(), binding: OTPVerify2Binding()),
      ],
      initialRoute: "/register",
      builder: EasyLoading.init(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCube
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 18.0
    ..radius = 8.0
    ..progressColor = Color(0xFF8E92A8)
    ..backgroundColor = Colors.white70
    ..indicatorColor = Color(0xFF414B70)
    ..textColor = Color(0xFF8E92A8)
    ..maskColor = Colors.black.withOpacity(0.6)
    ..maskType = EasyLoadingMaskType.custom
    ..textPadding = EdgeInsets.only(top: 6,bottom: 15)
    ..contentPadding = EdgeInsets.symmetric(vertical: 10, horizontal: 10)
    ..fontSize = 12.0
    ..userInteractions = false
    ..dismissOnTap = false;
}

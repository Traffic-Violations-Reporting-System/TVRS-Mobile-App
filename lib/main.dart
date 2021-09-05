import 'package:camera/camera.dart';
import 'package:etrafficcomplainer/screens/login/binding/login_binding.dart';
import 'package:etrafficcomplainer/screens/login/view/login.dart';
import 'package:etrafficcomplainer/screens/otp_verify/binding/otp_verify_binding.dart';
import 'package:etrafficcomplainer/screens/otp_verify/view/otp_verify.dart';
import 'package:etrafficcomplainer/screens/otp_verify_2/binding/otp_verify_2_binding.dart';
import 'package:etrafficcomplainer/screens/otp_verify_2/view/otp_verify_2.dart';
import 'package:etrafficcomplainer/screens/pages/complaints/binding/complaint_status_binding.dart';
import 'package:etrafficcomplainer/screens/pages/complaints/view/view_mycomplaint_status.dart';
import 'package:etrafficcomplainer/screens/pages/record/view/record.dart';
import 'package:etrafficcomplainer/screens/screen_controller/binding/screencontroller_binding.dart';
import 'package:etrafficcomplainer/screens/screen_controller/view/screencontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:etrafficcomplainer/screens/home/binding/home_binding.dart';
import 'package:etrafficcomplainer/screens/home/view/home.dart';
import 'package:etrafficcomplainer/screens/register/binding/register_binding.dart';
import 'package:etrafficcomplainer/screens/register/view/register.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  final secondaryColor = Color(0xFF8E92A8);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: secondaryColor
  ));

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
        GetPage(name: "/screen_controller", page: ()=>ScreenController(), binding: ScreenControllerBinding()),
        GetPage(name: "/home", page: ()=>HomeScreen(), binding: HomeBinding()),
        GetPage(name: "/register", page: ()=>RegisterScreen(), binding: RegisterBinding()),
        GetPage(name: "/login", page: ()=>LoginScreen(), binding: LoginBinding()),
        GetPage(name: "/otp_verify", page: ()=>OTPVerifyScreen(), binding: OTPVerifyBinding()),
        GetPage(name: "/otp_verify_2", page: ()=>OTPVerify2Screen(), binding: OTPVerify2Binding()),
        GetPage(name: "/complaintStatus", page: ()=>MyComplaintScreen(), binding: complaintStatusBinding()),
      ],
      initialRoute: "/login",
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
    ..progressColor = Color(0xFF414B70)
    ..progressWidth = 3
    ..backgroundColor = Colors.white70
    ..indicatorColor = Color(0xFF414B70)
    ..textColor = Color(0xFF414B70)
    ..maskColor = Color(0xFF151929).withOpacity(0.4)
    ..maskType = EasyLoadingMaskType.custom
    ..textPadding = EdgeInsets.only(top: 6,bottom: 15)
    ..contentPadding = EdgeInsets.symmetric(vertical: 10, horizontal: 10)
    ..fontSize = 12.0
    ..userInteractions = false
    ..dismissOnTap = false;
}

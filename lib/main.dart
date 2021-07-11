import 'package:etrafficcomplainer/screens/login/binding/login_binding.dart';
import 'package:etrafficcomplainer/screens/login/view/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:etrafficcomplainer/screens/home/binding/home_binding.dart';
import 'package:etrafficcomplainer/screens/home/view/home.dart';
import 'package:etrafficcomplainer/screens/register/binding/register_binding.dart';
import 'package:etrafficcomplainer/screens/register/view/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'e Traffic Complainer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      getPages: [
        GetPage(name: "/home", page: ()=>HomeScreen(), binding: HomeBinding()),
        GetPage(name: "/register", page: ()=>RegisterScreen(), binding: RegisterBinding()),
        GetPage(name: "/login", page: ()=>LoginScreen(), binding: LoginBinding()),
      ],
      initialRoute: "/login",
    );
  }
}

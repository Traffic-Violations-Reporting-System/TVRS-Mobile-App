
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8E92A8),
      body: Center(
        child: Image.asset("assets/img/e_logo.png", height: 80, width: 120,),
      ),
    );
  }
}
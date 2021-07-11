import 'package:etrafficcomplainer/screens/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {

  final primaryColor = Color(0xFF414B70);
  final whiteColor = Color(0xFFFFFFFF);
  final backgroundGradient = LinearGradient(colors: [Colors.white, Color(0xFFEEEEEC)], begin: Alignment.topCenter, end: Alignment.bottomCenter,);
  final secondaryColor = Color(0xFF8E92A8);
  final borderEnableColor = Color(0xFFF6F6F6);
  final hintTextColor = Color(0xFFB2B5C4);
  final dropshadowColor = Color(0x1A4B4B4B);

  Widget getTextFormField({required String hint, required TextEditingController controller, required Function validator, double paddingTop = 8.0}){
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: TextFormField(
        style: TextStyle(fontSize: 18.0,),
        decoration: InputDecoration(
          fillColor: whiteColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: secondaryColor, width: 1.0),
            borderRadius: const BorderRadius.all(
              const Radius.circular(8.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderEnableColor, width: 1.0),
            borderRadius: const BorderRadius.all(
              const Radius.circular(8.0),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          hintText: hint,
          hintStyle: TextStyle(color: hintTextColor, fontSize: 14.0),
        ),
        controller: controller,
        validator: (value) {
          return validator(value);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("login is build!");
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
            image: DecorationImage(
                image: AssetImage("assets/img/back_vec_1.png"),
                fit: BoxFit.contain,
                alignment: Alignment.topCenter
            ),
        ),

        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 30,),
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/img/logo.png"),
                                fit: BoxFit.contain,
                                alignment: Alignment.center
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: new Column(
                      children: [

                        Form(

                          key: controller.loginFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[

                              getTextFormField(hint: "Email", controller: controller.emailController, validator: (value){
                                if(!GetUtils.isEmail(value!)){
                                  return "Required!";
                                }
                                else{
                                  return null;
                                }
                              }),
                              getTextFormField(hint: "Password", controller: controller.passwordController, validator: (value){
                                if(value!.isEmpty){
                                  return "Required!";
                                }
                                else{
                                  return null;
                                }
                              },paddingTop:16.0),

                              SizedBox(height: 22),
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
                                    controller.loginUser();
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
                                  child: Text("Login"),
                                ),
                              ),
                              SizedBox(height: 21),
                              Container(
                                child: new InkWell(
                                  child: new Text('forgot your password?',style: TextStyle(color: Color(0xFF414B70)),),

                                ),


                              ),
                              SizedBox(height:200 ,),
                              new Divider()
                            ],

                          ),


                        ),
                        SizedBox(height: 23,),
                        Text("Dont have an account?", style: TextStyle(color:primaryColor ),),
                        SizedBox(height: 15,),
                        new Container(
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


                              child: Text("Register"),

                            ),

                          ),

                      ],


                    ),


                  ),


                ),

              ],

            ),

          ),
        ),

      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:etrafficcomplainer/screens/otp_verify/controller/otp_verify_controller.dart';

class OTPVerifyScreen extends StatelessWidget {

  final otpController = Get.find<OTPVerifyController>();

  final primaryColor = Color(0xFF414B70);
  final secondaryColor = Color(0xFF8E92A8);
  final whiteColor = Color(0xFFFFFFFF);
  final backgroundGradient = LinearGradient(colors: [Colors.white, Color(0xFFEEEEEC)], begin: Alignment.topCenter, end: Alignment.bottomCenter,);

  @override
  Widget build(BuildContext context) {
    print("otp is build!");
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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                  icon: Icon(CupertinoIcons.clear),
                  color: primaryColor,
                  onPressed: (){

               },
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text("Hi, ${otpController.getWelcomeName()}",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              )
                  ),
                  SizedBox(height: 8),
                  Text("Go ahead and verify your mobile no.",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: secondaryColor,
                      )
                  ),
                  SizedBox(height: 38),
                  TextFormFieldWidget(),
                ],
              ),
            ),
          ),
        ),
    );
  }
}

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({Key? key}) : super(key: key);

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {

  final otpController = Get.find<OTPVerifyController>();
  final mnoController = TextEditingController();

  final primaryColor = Color(0xFF414B70);
  final secondaryColor = Color(0xFF8E92A8);
  final whiteColor = Color(0xFFFFFFFF);
  final borderEnableColor = Color(0xFFF6F6F6);
  final hintTextColor = Color(0xFFB2B5C4);
  final redColor = Color(0xFFFF6666);
  final dropshadowColor = Color(0x1A4B4B4B);

  @override
  void dispose() {
   // mnoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: otpController.mnoFormKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0),
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
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: redColor, width: 1.0),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(8.0),
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: redColor, width: 1.0),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(8.0),
                  ),
                ),
                errorStyle: TextStyle(color: redColor),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                hintText: "Mobile Number",
                hintStyle: TextStyle(color: hintTextColor, fontSize: 14.0),
              ),
              keyboardType: TextInputType.phone,
              controller: mnoController,
              validator: (value){
                if(value!.length != 10){
                  return "Invalid mobile number.";
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 32),
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
              onPressed: (){
                FocusScope.of(context).unfocus();
                otpController.sendOTP(mnoController.text.trim());
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
              child: Text("Send verification code"),
            ),
          ),
        ],
      ),
    );
  }
}


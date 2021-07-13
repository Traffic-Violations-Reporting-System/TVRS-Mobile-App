import 'package:etrafficcomplainer/screens/otp_verify_2/controller/otp_verify_2_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerify2Screen extends StatelessWidget {

  final otp2Controller = Get.find<OTPVerify2Controller>();

  final primaryColor = Color(0xFF414B70);
  final secondaryColor = Color(0xFF8E92A8);
  final backgroundGradient = LinearGradient(colors: [Colors.white, Color(0xFFEEEEEC)], begin: Alignment.topCenter, end: Alignment.bottomCenter,);
  final redColor = Color(0xFFFF6666);

  @override
  Widget build(BuildContext context) {
    print("otp2 is build!");
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
              leading: BackButton(
                  color: primaryColor
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text("OTP Verification", style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  )
                  ),
                  SizedBox(height: 8),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: secondaryColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'We sent your code to '),
                        TextSpan(text: '${otp2Controller.getMno()}', style: new TextStyle(color: primaryColor, fontWeight: FontWeight.w500,)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('This code will expired in ', style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: secondaryColor,
                      ),),
                      TweenAnimationBuilder<Duration>(
                        tween: Tween(begin: Duration(minutes: 3), end: Duration.zero),
                        duration: const Duration(minutes: 3),
                        builder: (BuildContext context, Duration value, child) {
                          final minutes = value.inMinutes;
                          final seconds = value.inSeconds % 60;
                          return Text(
                            "0$minutes:${seconds < 10? '0'+seconds.toString() : seconds}",
                            style: TextStyle(
                              color: redColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            )
                          );
                        },
                        onEnd: (){

                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 38),
                  OTPForm(),
                  SizedBox(height: 31),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Didn\'t receive the code?  '),
                          TextSpan(text: 'RESEND', style: new TextStyle(color: primaryColor, fontWeight: FontWeight.w500, decoration: TextDecoration.underline,)
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


class OTPForm extends StatefulWidget {

  const OTPForm({Key? key}) : super(key: key);

  @override
  _OTPFormState createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {

  final redColor = Color(0xFFFF6666);
  final greenColor = Color(0xFF67C2C9);
  final secondaryColor = Color(0xFF8E92A8);
  final dropshadowColor = Color(0x1A4B4B4B);
  final primaryColor = Color(0xFF414B70);
  final whiteColor = Color(0xFFFFFFFF);

  final otp2Controller = Get.find<OTPVerify2Controller>();
  final otpCodeController = TextEditingController();

  @override
  void dispose() {
   // otpCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: otp2Controller.otpFormKey,
      child: Column(
        children: [
          PinCodeTextField(
            errorTextSpace: 0,
            appContext: context,
            length: 6,
            obscureText: false,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.phone,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                borderWidth: 1,
                fieldHeight: 53,
                fieldWidth: 48,
                activeColor: greenColor,
                selectedColor: secondaryColor,
                inactiveColor: secondaryColor,
                activeFillColor: Colors.white,
                selectedFillColor: Colors.white,
                inactiveFillColor: Colors.white
            ),
            animationDuration: Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
            controller: otpCodeController,
            autovalidateMode: AutovalidateMode.disabled,
            cursorColor: primaryColor,
            onCompleted: (v) {
              print("Complete");
              otp2Controller.isComplete = true;
            },
            onChanged: (value) {
              print("Changing..");
              otp2Controller.isComplete = false;
              otp2Controller.isTapVerifyBtn.value = false;
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
          ),
          SizedBox(height: 10),
          Obx(() => otp2Controller.isTapVerifyBtn.isTrue? Align(alignment: Alignment.topLeft ,child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text("Please enter a valid code.", style: TextStyle( color: redColor, fontSize: 12)),
          )) : SizedBox.shrink(),),
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
              onPressed: (){
                otp2Controller.otpVerify(otpCodeController.text, context);
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
              child: Text("Verify"),
            ),
          ),
        ],
      ),
    );
  }
}


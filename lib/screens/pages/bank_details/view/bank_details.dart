import 'package:etrafficcomplainer/screens/pages/bank_details/controller/bank_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankDetailsScreen extends StatelessWidget{

  final controller = Get.find<BankDetailsController>();
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


  Widget getTextFormField({required String hint, required TextEditingController controller, required Function validator, double paddingTop = 10.0, bool obscureText = false}){
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: TextFormField(
        cursorColor: primaryColor,
        style: TextStyle(fontSize: 14.0,),
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
          hintText: hint,
          hintStyle: TextStyle(color: hintTextColor, fontSize: 14.0),
        ),
        controller: controller,
        validator: (value) {
          return validator(value);
        },
        obscureText: obscureText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(

          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: backgroundGradient,
            image: DecorationImage(
                image: AssetImage("assets/img/back_vec_1.png"),
                fit: BoxFit.contain,
                alignment: Alignment.topCenter
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,top: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bank Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 20,),

                  Container(

                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: EdgeInsets.only(right: 20),
                    height: 365,
                    width: 330,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getTextFormField(hint: "Account Holder Name", controller: controller.bankNameController, validator: (value){
                            if(value!.isEmpty){
                              return "Required!";
                            }
                            else{
                              return null;
                            }
                          }),
                          Container(
                            child: Divider(
                              color: hintTextColor,
                            ),
                          ),

                          getTextFormField(hint: "Bank Name", controller: controller.bankNameController, validator: (value){
                            if(value!.isEmpty){
                              return "Required!";
                            }
                            else{
                              return null;
                            }
                          }),
                          Container(
                            child: Divider(
                              color: hintTextColor,
                            ),
                          ),

                          getTextFormField(hint: "Branch Name", controller: controller.bankNameController, validator: (value){
                            if(value!.isEmpty){
                              return "Required!";
                            }
                            else{
                              return null;
                            }
                          }),
                          Container(
                            child: Divider(
                              color: hintTextColor,
                            ),
                          ),

                          getTextFormField(hint: "Branch Code", controller: controller.bankNameController, validator: (value){
                            if(value!.isEmpty){
                              return "Required!";
                            }
                            else{
                              return null;
                            }
                          }),
                          Container(
                            child: Divider(
                              color: hintTextColor,
                            ),
                          ),

                          getTextFormField(hint: "Account Number", controller: controller.bankNameController, validator: (value){
                            if(value!.isEmpty){
                              return "Required!";
                            }
                            else{
                              return null;
                            }
                          }),


                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 14,bottom: 10,right: 20),
                        width: 150,
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
                            FocusScope.of(context).unfocus();
                            // Get.offNamed("/add_payout_option");
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              backgroundColor: MaterialStateProperty.all(primaryColor),
                              foregroundColor: MaterialStateProperty.all(whiteColor),
                              textStyle: MaterialStateProperty.all(TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ))
                          ),
                          child: Text("Confirm Bank Details"),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 14,bottom: 10,right: 20),
                        width: 150,
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
                            FocusScope.of(context).unfocus();
                            Get.offNamed("/home");
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              backgroundColor: MaterialStateProperty.all(secondaryColor),
                              foregroundColor: MaterialStateProperty.all(whiteColor),
                              textStyle: MaterialStateProperty.all(TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ))
                          ),
                          child: Text("Cancel"),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          )
        )
    );
  }

}
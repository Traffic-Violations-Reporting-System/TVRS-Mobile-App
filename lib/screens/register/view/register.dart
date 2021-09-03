
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:etrafficcomplainer/screens/register/controller/register_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';

class RegisterScreen extends GetView<RegisterController> {

  final primaryColor = Color(0xFF414B70);
  final secondaryColor = Color(0xFF8E92A8);
  final whiteColor = Color(0xFFFFFFFF);
  final backgroundGradient = LinearGradient(colors: [Colors.white, Color(0xFFEEEEEC)], begin: Alignment.topCenter, end: Alignment.bottomCenter,);
  final borderEnableColor = Color(0xFFF6F6F6);
  final hintTextColor = Color(0xFFB2B5C4);
  final dropshadowColor = Color(0x1A4B4B4B);
  final redColor = Color(0xFFFF6666);
  final popupBarrierColor = Color(0xFF151929).withOpacity(0.4);

  Widget getTextFormField({required String hint, required TextEditingController controller, required Function validator, double paddingTop = 16.0, bool obscureText = false}){
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
    print("register is build!");
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
                              height: 80,
                              width: 120,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/img/e_logo.png"),
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child:   OutlinedButton(
                                child: Row(
                                  children: [
                                    Text('Login'),
                                    SizedBox(width: 3,),
                                    Icon(CupertinoIcons.lock_shield_fill, color: primaryColor, size: 19,)
                                  ],
                                ),
                                style: OutlinedButton.styleFrom(
                                  primary: primaryColor,
                                  backgroundColor: Colors.transparent,
                                  side: BorderSide(color: primaryColor, width: 1),
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  controller.loginUser();
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                            child: Form(
                              key: controller.registerFormKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  getTextFormField(hint: "Full Name", controller: controller.fullNameController, validator: (value){
                                    if(value!.isEmpty){
                                      return "Required!";
                                    }
                                    else{
                                      return null;
                                    }
                                  }, paddingTop: 32),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: DropdownSearch<String>(
                                      mode: Mode.DIALOG,
                                      showSelectedItem: false,
                                      items: [
                                        "PD001 - Colombo Police Head Office",
                                        "PD002 - Matara Police Devision",
                                        "PD003 - Galle Police Devision",
                                        "PD004 - Hambanthota Police Devision",
                                        "PD005 - Kalutara Police Devision",
                                        "PD006 - Dickwella Police Devision",
                                        "PD007 - Kamburupitiya Police Devision",
                                        "PD008 - Akuressa Police Devision",
                                      ],
                                      hint: "Nearest Police Division",
                                      onChanged: (text) {if(text!=null) controller.npdController.text = text;},
                                      showSearchBox: true,
                                      popupBarrierColor: popupBarrierColor,
                                      popupShape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8.0))
                                      ),
                                      searchFieldProps: TextFieldProps(cursorColor: secondaryColor, cursorWidth: 1.5),
                                      searchBoxDecoration: InputDecoration(
                                        suffixIcon: Icon(CupertinoIcons.search_circle_fill, size: 19, color: primaryColor,),
                                        fillColor: whiteColor,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: secondaryColor, width: 1),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(8.0),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: borderEnableColor, width: 1.5),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(8.0),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
                                        hintText: "Search",
                                        hintStyle: TextStyle(color: hintTextColor, fontSize: 14.0),
                                      ),
                                      searchBoxController: controller.npdController,
                                      dropdownSearchBaseStyle: TextStyle(fontSize: 18.0,),
                                      dropDownButton: Icon(CupertinoIcons.chevron_down_circle_fill, size: 19, color: primaryColor,),
                                      dropdownSearchDecoration: InputDecoration(
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
                                        contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                                        hintStyle: TextStyle(color: hintTextColor, fontSize: 14.0),
                                      ),
                                      validator: (value){
                                        if(value == null || value.isEmpty){
                                          return "Required!";
                                        }
                                        else{
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  getTextFormField(hint: "National ID", controller: controller.nicController, validator: (value){
                                    if(value!.isEmpty){
                                      return "Required!";
                                    }
                                    else if(value.length < 10 || value.length > 12 || value.length == 11){
                                      return "Invalid NIC number!";
                                    }
                                    else{
                                      return null;
                                    }
                                  }),
                                  getTextFormField(hint: "Password", controller: controller.passwordController, obscureText: true, validator: (value){
                                    if(value!.isEmpty){
                                      return "Required!";
                                    }
                                    else if(value.length < 8){
                                      return "Password must be 8 characters long.";
                                    }
                                    else{
                                      return null;
                                    }
                                  }),
                                  getTextFormField(hint: "Confirm Password", controller: controller.confirmPasswordController, obscureText: true, validator: (value){
                                    if(value != null && value!.isEmpty){
                                      return "Required!";
                                    }
                                    else if(value != controller.passwordController.text){
                                      return "Password mismatched!";
                                    }
                                    else{
                                      return null;
                                    }
                                  }),
                                  SizedBox(height: 25),
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
                                        FocusScope.of(context).unfocus();
                                        controller.registerUser();
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
                                      child: Text("Register"),
                                    ),
                                  ),
                                  SizedBox(height: 22),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xFF8E92A8),
                                      ),
                                      children: <TextSpan>[
                                         TextSpan(text: 'By registering, you are agreeing to our '),
                                         TextSpan(text: 'Terms and Conditions', style: new TextStyle(fontWeight: FontWeight.bold)),
                                         TextSpan(text: ' and '),
                                         TextSpan(text: 'Privacy & Policies.', style: new TextStyle(fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 25),
                              ],
                            ),

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

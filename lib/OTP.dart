import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'home.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  @override
  Widget build(BuildContext context) {
    ///Take 6 digit OTP as input from user
    ///Verify OTP with Firebase
    ///If OTP is correct, navigate to HomePage
    ///Else, show error message
    ///
    String currentText = "";
    StreamController<ErrorAnimationType> errorController = StreamController();
    bool hasError = false;
    FocusNode focusNode = FocusNode();
    TextEditingController controller = TextEditingController();
    bool termsAndConditionsAccepted = false;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Container(
        margin: EdgeInsets.only(
        left: width * 0.1,
            right: width * 0.1,
            top: height * 0.05),
        child: RichText(
          text: TextSpan(
              text: 'A One-time Password has been sent to your ',
              style: TextStyle(
                  color: Color.fromRGBO(78, 89, 111, 1),
                  fontFamily: 'Manrope',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600),
              children: <TextSpan>[
                TextSpan(
                  text: 'mobile number.',
                  style: TextStyle(
                      color: Color.fromRGBO(78, 89, 111, 1),
                      fontFamily: 'Manrope',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600),
                  children: [
                    TextSpan(
                        text: ' Tap to change number',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                        style: TextStyle(
                            color: Color.fromRGBO(114, 224, 223, 1),
                            fontFamily: 'Manrope',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600))
                  ],
                )
              ]),
        ),
      ),
              //OTP Field
              Container(
                margin: EdgeInsets.only(
                    left: width * 0.1,
                    right: width * 0.1,
                    top: height * 0.05),
                child: const Text(
                  "Enter OTP",
                  style: TextStyle(
                      color: Color.fromRGBO(78, 89, 111, 1),
                      fontFamily: 'Manrope',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: height * 0.15,
                    width: width,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: height / 30, horizontal: width / 30),
                        child: PinCodeTextField(
                          focusNode: focusNode ,
                          enablePinAutofill: true,
                          appContext: context,
                          length: 6,
                          animationType: AnimationType.scale,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            selectedColor: Color.fromRGBO(78, 89, 111, 0.3),
                            inactiveColor: Color.fromRGBO(78, 89, 111, 0.3),
                            activeColor: Color.fromRGBO(99, 196, 51, 1),
                            fieldHeight: height / 15,
                            fieldWidth: width / 7,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: Duration(milliseconds: 300),
                          textStyle: TextStyle(fontSize: 20, height: 1.6),
                          errorAnimationController: errorController,
                          controller: controller,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            return true;
                          },
                        )),
                  ),
                ],
              ),
              ///Elevated Button
              Container(
                margin: EdgeInsets.only(
                    left: width * 0.1,
                    right: width * 0.1,
                    top: height * 0.05),
                child: ElevatedButton(
                  onPressed: () {
                    if (currentText.length != 6) {
                      errorController.add(ErrorAnimationType.shake);
                      setState(() {
                        hasError = true;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()));
                    } else {
                      setState(() {
                        hasError = false;
                      });

                    }
                  },
                  child: const Text(
                    "Verify",
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Manrope',
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(99, 196, 51, 1),
                    minimumSize: Size(width * 0.8, height * 0.07),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
    ],)

      ),
    );

  }
}

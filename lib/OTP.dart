// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'home.dart';
import 'home_v2.dart';

class OTPPage extends StatefulWidget {
  final String phoneNumber;
  const OTPPage({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  late Timer _timer;
  int timeRem = 30;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timeRem == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          // print(timeRem);
          setState(() {
            timeRem--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

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
    // startTimer();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(0.027 * width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //texts
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      // height: ,
                      child: Icon(
                        Icons.arrow_back,
                        size: width * 0.085,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 32,
                    child: Container(),
                  ),
                  const Text(
                    "We have sent a verification code to",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Inter',
                        fontSize: 16),
                  ),
                  Flexible(
                    flex: 61,
                    child: Container(),
                  ),
                ],
              ),
              Center(
                child: Text(
                  widget.phoneNumber,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Inter',
                      fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //input otp

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.15,
                    width: width * 0.536,
                    child: PinCodeTextField(
                      focusNode: focusNode,
                      enablePinAutofill: true,
                      appContext: context,
                      length: 6,
                      animationType: AnimationType.scale,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        selectedColor: const Color.fromRGBO(78, 89, 111, 0.3),
                        inactiveColor: const Color.fromRGBO(78, 89, 111, 0.3),
                        activeColor: const Color(0xfff6d7d7),
                        fieldHeight: width * 0.084,
                        fieldWidth: width * 0.077,
                        borderRadius: BorderRadius.circular(3),
                        borderWidth: 0.5,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Inter',
                          fontSize: 16),
                      errorAnimationController: errorController,
                      controller: controller,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {
                        print("Completed");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePageV2(
                                )));
                      },
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
                    ),
                  ),
                ],
              ),
              Flexible(
                flex: 611,
                child: Container(),
              ),
              //timer
              Center(
                child: Text(
                  "0:$timeRem",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Inter',
                      fontSize: 16),
                ),
              ),

              Flexible(
                flex: 19,
                child: Container(),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //didn't receive
                  const Text(
                    "Didn't receive the code?",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Inter',
                        fontSize: 16),
                  ),
                  //resend
                  InkWell(
                    child: Container(
                      child: const Text(
                        "Resend now",
                        style: TextStyle(
                            color: Color(0xffC4C4C4),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Inter',
                            fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
              Flexible(
                flex: 28,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

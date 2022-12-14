import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:happyours/OTP.dart';
import 'package:happyours/emailLogin.dart';
import 'package:happyours/listPage.dart';
import 'package:happyours/home.dart';

import 'auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  // Create a Login page UI with a
  // logo
  //  a phone number field followed by OTP button OR Google Login
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    FocusNode focusNode = FocusNode();
    TextEditingController controller =
        TextEditingController(text: "+1(470)902-1657");
    // +1 (470) 902-1657
    return Scaffold(
      backgroundColor: const Color(0xfff6d7d7),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Image widget with logo.png from assets
              Container(
                height: width * 0.93,
                width: width * 1.007,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              //Phone Number Field
              Container(
                margin: EdgeInsets.only(left: width * 0.077),
                child: Row(
                  children: [
                    Container(
                      width: width * 0.86,
                      height: width * 0.155,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mobile No.',
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              fontSize: 27),
                        ),
                        focusNode: focusNode,
                        controller: controller,
                        autofocus: false,
                        onTap: () =>
                            FocusScope.of(context).requestFocus(focusNode),
                        keyboardType: TextInputType.phone,
                        onSubmitted: (v) {
                          FocusScope.of(context).unfocus();
                        },
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            fontSize: 27),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: width * 0.05,
              ),
              //Send OTP Button
              InkWell(
                onTap: () {
                  //TODO : Send OTP to Phone Number
                  //TODO : Navigate to OTP Page
                  Auth()
                      .loginWithPhoneNumber(phoneNumber: controller.text)
                      .then((_) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OTPPage(
                                    phoneNumber: controller.text,
                                  ))));
                },
                child: Container(
                  width: width * 0.86,
                  height: width * 0.155,
                  // margin: EdgeInsets.only(left: width * 0.077),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: const Center(
                    child: Text(
                      'Send OTP',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                          fontSize: 22),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: width * 0.082,
              ),
              Container(
                width: width * 0.86,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 20.0),
                        child: const Divider(
                          color: Colors.black,
                          // height: 36,
                        ),
                      ),
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                          fontSize: 15),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20.0),
                        child: const Divider(
                          color: Colors.black,
                          // height: 36
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: width * 0.082,
              ),
              //Login with email
              Container(
                width: width * 0.86,
                height: width * 0.155,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const emailLogin()));

                    // loginUserDb(context, _emailTextController,
                    // _passwordTextController);
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(flex: 1, child: Container()),
                      Icon(
                        Icons.email,
                        color: Colors.black,
                        size: width * 0.08,
                      ),
                      Flexible(flex: 5, child: Container()),
                      const Text(
                        "Continue with Email",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            fontSize: 19),
                      ),
                      Flexible(flex: 4, child: Container()),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: width * 0.05,
              ),
              //Terms of services
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "By continuing, you agree to our",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //terms of service
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          "Terms of Service",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      //privacy policy
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          "Privacy Policy",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      //content policy
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          "Content Policy",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: width * 0.05,
                  ),
                ],
              ),
              SizedBox(
                height: width * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //terms of service
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: const Text(
                      "Continue as Guest",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

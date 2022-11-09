import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:happyours/OTP.dart';
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
    TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 215, 215, 1),
      body: SafeArea(
        child: Center(

          child: Column(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Image widget with logo.png from assets
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              //Phone Number Field
            Column(

              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: width * 0.07, right: width * 0.1),
                  child: const Text(
                    "Enter your mobile number below to log in.",
                    style: TextStyle(
                        color: Color.fromRGBO(78, 89, 111, 0.6),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Manrope'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: width * 0.05, right: width * 0.02),
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.14,
                        alignment: Alignment.center,
                        child: const Text(
                          "+1",
                          style: TextStyle(
                              color: Color.fromRGBO(78, 89, 111, 1),
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Manrope',
                              fontSize: 18.5),
                        ),
                      ),
                      Container(
                        width: width * 0.65,
                        alignment: Alignment.center,
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: 'Mobile No.',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(78, 89, 111, 0.6),
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Manrope',
                                  fontSize: 18.5),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color:
                                      Color.fromRGBO(99, 196, 51, 1))),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromRGBO(78, 89, 111, 0.2),
                                ),
                              ),
                              focusColor: Color.fromRGBO(99, 196, 51, 1)),
                          focusNode: focusNode,
                          controller: controller,
                          autofocus: false,
                          onTap: () => FocusScope.of(context)
                              .requestFocus(focusNode),
                          keyboardType: TextInputType.phone,
                          onSubmitted: (v) {
                            FocusScope.of(context).unfocus();
                          },
                          style: const TextStyle(
                              color: Color.fromRGBO(78, 89, 111, 1),
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Manrope',
                              fontSize: 18.5),
                        ),
                      ),
                    ],
                  ),
                ),
              //Send OTP Button
              Container(
                width: width*0.8,
                child: ElevatedButton(
                  onPressed: () {
                    //TODO : Send OTP to Phone Number
                    //TODO : Navigate to OTP Page
                    Auth().loginWithPhoneNumber(phoneNumber: controller.text)
                    .then((_) => Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => OTPPage())));
                  },
                  child: const Text('Send OTP'),
                ),
              ),
              ///Create ----------OR-------------
              const Text('-------------OR-------------'),
              //Google Login Button
              Container(
                width: width*0.8,
                child: ElevatedButton(
                  onPressed: () {
                    Auth().signInWithGoogle().then((_) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage())));
                  },
                  child: const Text('Login with Google'),
                ),
              ),
            ],
            )]
          ),
        ),
        ),
    );
  }
}

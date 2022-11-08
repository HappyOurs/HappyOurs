import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
    return Scaffold(
        body: Container(
            child: Column(
      children: [
        Container(
            child: Text("Logo"),
            ),
        Container(
            child: Text("Phone Number Field"),
            ),
        Container(
            child: Text("OTP Button"),
            ),
        Container(
            child: Text("Google Login"),
            ),
      ],
    )));
  }
}
  }
}

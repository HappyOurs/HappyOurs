import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:happyours/auth.dart';

import 'home.dart';

/// Standard email ID and Login Page for the App in Flutter

BaseAuth auth = Auth();

class emailLogin extends StatefulWidget {
  const emailLogin({Key? key}) : super(key: key);

  @override
  State<emailLogin> createState() => _emailLoginState();
}

class _emailLoginState extends State<emailLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool checkingLoginMethods = false;
  bool isLogin = false;
  bool isSignUp = false;
  bool isPasswordVisible = false;
  LoginSettings loginSettings = LoginSettings();

  loginControl(email) {
    setState(() {
      checkingLoginMethods = true;
    });
    auth.getLoginSettings(email: email).then((value) {
      if (kDebugMode) {
        print(value);
      }
      loginSettings = value;

      setState(() {
        checkingLoginMethods = false;
        if (loginSettings.checkingCompleted) {
          if (loginSettings.isEmailID) {
            isLogin = true;
            isSignUp = false;
          } else {
            isSignUp = true;
            isLogin = false;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Welcome to Happy Hours",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Please enter your email ID",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextField(
              controller: emailController,
              onSubmitted: (String email) {
                loginControl(email);
              },
              decoration: InputDecoration(
                suffix: IconButton(
                    onPressed: () => loginControl(emailController.text),
                    icon: checkingLoginMethods
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.check)),
                border: const OutlineInputBorder(),
                labelText: 'Email ID',
              ),
            ),
            Visibility(
              visible: isLogin || isSignUp,
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Visibility(
              visible: isSignUp,
              child: TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (isLogin || isSignUp) {
                  try {
                    await auth
                        .allLoginMethodsUsingEmail(
                            loginSettings: loginSettings,
                            email: emailController.text,
                            password: passwordController.text,
                            password2: confirmPasswordController.text)
                        .then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage())));
                  } catch (e) {
                    print(e);
                  }
                } else {
                  loginControl(emailController.text);
                }
              },
              child: isLogin
                  ? Text('Login')
                  : isSignUp
                      ? Text('Sign Up')
                      : Text('Check'),
            ),
          ],
        ),
      ),
    );
  }
}

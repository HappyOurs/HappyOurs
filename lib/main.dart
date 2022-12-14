import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happyours/listPage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'auth.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'login.dart';

// ...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    BaseAuth auth = new Auth();
    if (auth.getCurrentUser() != null) {
      return OverlaySupport(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'HappyOurs',
              theme: ThemeData(
                fontFamily: 'Nunito',
                primaryColor: const Color(0xff29a39d),
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: const Color(0xff29a39d)),
              ),
              home: const HomePage()));

      //TODO : Change to splashScreen
      //TODO : Fix Cloud Functions for Updating name and Email ID

    } else {
      return OverlaySupport(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'HappyOurs',
              theme: ThemeData(
                fontFamily: 'Nunito',
                primaryColor: const Color(0xff29a39d),
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: const Color(0xff29a39d)),
              ),
              home: Login()));
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:happyours/home.dart';
import 'package:overlay_support/overlay_support.dart';
import 'auth.dart';
import 'firebase_options.dart';
import 'login.dart';

// ...



Future<void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
          BaseAuth auth = new Auth();
          if (auth.getCurrentUser() != null) {
              Future<DocumentSnapshot<Map<String, dynamic>>> userData =
                  userDocReference!
                      .get();
              return FutureBuilder(
                  // Initialize FlutterFire:
                  future: userData,
                  // ignore: missing_return
                  builder: (context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasData && snapshot.data!.data() != null) {
                        return OverlaySupport(
                            child: MaterialApp(
                                debugShowCheckedModeBanner: false,
                                title: 'HappyOurs',
                                theme: ThemeData(
                                  fontFamily: 'Nunito',
                                  primaryColor: const Color(0xff29a39d),
                                  colorScheme: ColorScheme.fromSwatch()
                                      .copyWith(
                                          secondary: const Color(0xff29a39d)),
                                ),
                                home: const HomePage()));
                      } 
                    //TODO : Change to splashScreen
                    //TODO : Fix Cloud Functions for Updating name and Email ID
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
                            home:Login()
                            ));
                  });
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


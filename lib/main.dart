import 'package:edmax/screens/homeScreen.dart';
import 'package:edmax/screens/profile.dart';
import 'package:edmax/utils/colors.dart';
import 'package:get/get.dart';

import 'screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'utils/colors.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey:"AIzaSyB2pz69RS1oAjABrKRIOostdgiRodM3m4U",
        appId:"1:698941466618:android:b7cca72e4d57b8fb926643",
        messagingSenderId:"698941466618",
        projectId:"ed-max-f2a03"),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/splashscreen",
      getPages: [
        GetPage(name: "/splashscreen", page: ()=>const Splash()),
        GetPage(name: "/login", page: ()=>const Login()),
        GetPage(name: "/", page: ()=> const HomeScreen()),
        GetPage(name: "/profile", page: ()=> ProfilePage()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'edmax',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: backgroundColor,
        ),
        scaffoldBackgroundColor: backgroundColor,
        // primaryTextTheme: Typography().white,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
          decorationColor: backgroundColor,
        ),
        dividerColor: Colors.white,
      ),
    );
  }
}

// Rest of your code remains unchanged

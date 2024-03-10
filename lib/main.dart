import 'package:edmax/screens/homeScreen.dart';
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
      initialRoute: "/login",
      getPages: [
        GetPage(name: "/login", page: ()=>const Login()),
        GetPage(name: "/", page: ()=> const HomeScreen()),
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
      ),
    );
  }
}

// Rest of your code remains unchanged

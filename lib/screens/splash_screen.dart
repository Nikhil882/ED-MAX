import 'dart:async';
import 'package:flutter/material.dart';
import 'package:edmax/screens/login.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late String finalEmail;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    // Start the animation after a delay
    Timer(Duration(seconds: 1), () {
      _animationController.forward();
    });

    // Navigate after the animation completes
    _animationController.addStatusListener((status) async{
      if (status == AnimationStatus.completed) {
        dynamic id = await SessionManager().get("token");
        Get.to(()=> id == "" ? Login() : setHomeScreen);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace Image.asset with your image widget
            FadeTransition(
              opacity: _animation,
              child: Image.asset(
                'assets/logo.jpg', // Replace with your image file path
                width: 200, // Adjust width as needed
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
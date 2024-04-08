import 'package:edmax/resources/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin", style: TextStyle(color: Colors.white),),

      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Sign Out"),
          onPressed: () => AuthMethods().signOut(),
        ),
      ),
    );
  }
}

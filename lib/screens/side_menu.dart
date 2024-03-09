
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
              child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/img_1.png"),
                  radius: 30,
                ),
              ),
              Text(
                "Jay Mhatre",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1
                ),
              ),
            ],
          )),
          ListTile(
            title: const Text("First"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Second"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Log out"),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.toNamed("/login");
            }
          ),
        ],
      ),
    );
  }
}

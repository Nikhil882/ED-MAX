import 'package:edmax/screens/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edmax/screens/profile.dart';
import 'package:edmax/screens/homeScreen.dart';

class SideMenu extends StatelessWidget {
  SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        body: ListView(
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
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text(
                "Student Details",
              ),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              onTap: () {
              }
            ),
            ListTile(
              title: const Text(
                "Parent Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                "Project",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                "Notes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                "Syllabus",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                "Result",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                "Book",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 120,
            ),
            ListTile(
              title: const Text(
                "Log out",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.toNamed("/login");
              },
              trailing: IconButton(
                icon: const Icon(Icons.settings),
                tooltip: "Settings",
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            // Icon(
            //   Icons.settings,
            //   color: Colors.white,
            // ),
          ],
        ),
      ),
    );
  }
}

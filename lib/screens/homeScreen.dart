import 'package:edmax/screens/carousel.dart';
import 'package:edmax/screens/quiz.dart';
import 'package:edmax/screens/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import carousel_slider
import 'package:edmax/screens/profile.dart';
import 'package:get/get.dart';
import 'login.dart';
import '../utils/colors.dart';
import '../constants/strings.dart';
import 'notifications.dart';
import 'package:edmax/screens/Assignment.dart';
import 'package:edmax/screens/attendance.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "EDU VENTURE",
                style: TextStyle(
                  color: Colors.white,
                ),
                // textAlign: TextAlign.center,
              ),
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () => Get.to(const Notifications()),
              )
            ],
          ),
        ),
        centerTitle: true,
      ),
      drawer: SideMenu(),
      body: Column(
        children: [
          // Carousel in the first half
          // Container(
          //   color: Colors.black,
          //   height: 200,
          //   width: 300,// Adjust the height as needed
          //   child: CarouselSlider(
          //     options: CarouselOptions(
          //       height: 200,
          //       enlargeCenterPage: true,
          //       autoPlay: true,
          //       aspectRatio: 16 / 9,
          //       autoPlayCurve: Curves.fastOutSlowIn,
          //       enableInfiniteScroll: true,
          //     ),
          //     items: carouselImages.map((image) {
          //       return Builder(
          //         builder: (BuildContext context) {
          //           return Container(
          //             width: MediaQuery.of(context).size.width,
          //             margin: EdgeInsets.symmetric(horizontal: 5.0),
          //             decoration: BoxDecoration(
          //               color: Colors.amber,
          //             ),
          //             child: Image.asset(
          //               'assets/$image',
          //               fit: BoxFit.cover,
          //             ),
          //           );
          //         },
          //       );
          //     }).toList(),
          //   ),
          // ),
          // Bottom navigation and main content
          Expanded(
            child: Scaffold(
              bottomNavigationBar: CurvedNavigationBar(
                items: items.map((icon) {
                  int iconIndex = items.indexOf(icon);
                  return Icon(
                    icon.icon,
                    color: index == iconIndex ? Colors.white : Colors.black,
                    size: 30,
                  );
                }).toList(),
                index: index,
                onTap: (selectedIndex) {
                  setState(() {
                    index = selectedIndex;
                  });
                },
                height: 70,
                backgroundColor: backgroundColor,
                animationDuration: const Duration(milliseconds: 300),
                buttonBackgroundColor: Colors.blue,
              ),
              body: Container(
                color: backgroundColor,
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: getSelectedWidget(index: index),
              ),
              // drawer: Drawer(
              //   child: ListView(
              //     children: [
              //       const DrawerHeader(
              //         child: Text("ED-MAX"),
              //       ),
              //       ListTile(
              //         title: const Text("Profile"),
              //         onTap: () {},
              //       )
              //     ],
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = ProfilePage();
        break;
      case 1:
        // Replace this with the widget for Chat
        widget = Container(
          color: backgroundColor,
        );
        break;
      case 2:
        // Replace this with the widget for Home
        widget = HomePage();
        break;
      case 3:
        widget = const Quiz();
        // Replace this with the widget for Assignment
        //widget = Container(
        //   color: backgroundColor,

        break;
      case 4:
        // Replace this with the widget for Test
        widget = AttendanceScreen();
        //widget = Container();
        break;
      default:
        widget = Container();
        break;
    }
    return widget;
  }
}

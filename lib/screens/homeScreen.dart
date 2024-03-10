import 'package:edmax/screens/carousel.dart';
import 'package:edmax/screens/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import carousel_slider
import 'package:edmax/screens/profile.dart';
import 'package:get/get.dart';
import 'bottom_nav.dart';
import 'login.dart';
import '../utils/colors.dart';
import '../constants/strings.dart';

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
        title: const Text(
            "ED-MAX",
          style: TextStyle(
            color: Colors.white,
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
              bottomNavigationBar: const BottomNavBar(),
              body: Container(
                color: Colors.black87,
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: getSelectedWidget(index: 0),
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
          color: Colors.black,
        );
        break;
      case 2:
      // Replace this with the widget for Home
        widget = HomePage();
        break;
      case 3:
      // Replace this with the widget for Assignment
        widget = Container(
          color: Colors.black,
        );
        break;
      case 4:
      // Replace this with the widget for Test
        widget = Container(
          color: Colors.black,
        );
        break;
      default:
        widget = Container();
        break;
    }
    return widget;
  }
}

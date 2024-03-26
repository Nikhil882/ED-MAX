import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../utils/colors.dart';

// Declare the background color variable
 // You can set any color you want here

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> carouselImages = [
    'Cloud.png',
    'button.png',
    'image3.jpg',
  ];

  final PageController _pageController = PageController();
  int _currentPage = 1;

  final List<Map<String, String>> timetable = [
    {'lecture': 'Mathematics', 'time': '09:00 AM - 10:00 AM', 'progress': '30'},
    {'lecture': 'Science', 'time': '10:30 AM - 11:30 AM', 'progress': '50'},
    {'lecture': 'History', 'time': '12:00 PM - 01:00 PM', 'progress': '20'},
    {'lecture': 'English', 'time': '02:00 PM - 03:00 PM', 'progress': '70'},
  ];

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor, // Use the background color variable here
        child: Column(
          children: [
            // Carousel section
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentPage = index;
                        });
                      },

                    ),
                    items: carouselImages.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.4),
                                  spreadRadius: 4,
                                  blurRadius: 8,
                                ),
                              ],
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset(
                                'assets/$image',
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                // Page indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    carouselImages.length,
                        (index) => buildIndicator(index),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Timetable section
            Expanded(
              child: ListView.builder(
                itemCount: timetable.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timetable[index]['lecture']!,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(timetable[index]['time']!),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: double.parse(timetable[index]['progress']!) / 100,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Bottom navigation and main content
            Container(
              color: backgroundColor, // Use the background color variable here as well
              // Add your bottom navigation and main content here
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.blue : Colors.white,
      ),
    );
  }
}

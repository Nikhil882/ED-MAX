import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
        color: Colors.black,
        child: Column(
          children: [
            // Carousel in the first half
            Container(
              margin: EdgeInsets.all(16.0), // Adjust margins as needed
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes the shadow position
                  ),
                ],
              ),
              height: 300,
              width: 500, // Adjust the height as needed
              child: ClipRRect(
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
                      // Handle page change here
                    },
                  ),
                  items: carouselImages.map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
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
            ),
            // Page indicators
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    carouselImages.length,
                        (index) => buildIndicator(index),
                  ),
                ),
              ),
            ),
            // Bottom navigation and main content
            Container(
              color: Colors.white,
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
        color: _currentPage == index ? Colors.green : Colors.white,
      ),
    );
  }
}

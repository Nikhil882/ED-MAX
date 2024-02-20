import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:edmax/screens/login.dart';
import 'package:edmax/screens/signup.dart';

class OnBoardingPages extends StatelessWidget {
  const OnBoardingPages({super.key});

  @override
  Widget build(BuildContext context) {
    return const  OnBoardingPage();
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to edmax",
          body: "Discover the features of our app!",
          image: const Center(
            child: Icon(
              Icons.star,
              size: 150,
              color: Colors.orange,
            ),
          ),
        ),
        // Add more pages as needed
      ],
      onDone: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      ),
      showSkipButton: false,
      done: const Text('Done'),
      next: const Icon(Icons.arrow_forward),
      globalBackgroundColor: Colors.white,
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeColor: Colors.orange,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "xyz",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupScreen(),
                  ),
                );
              },
              child: const Text('Get Started'),
            ),
            const SizedBox(height: 15.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DummyScreen(),
                  ),
                );
              },
              child: const Text(
                'Already have an Account? Login',
                style: TextStyle(fontSize: 14.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DummyScreen extends StatelessWidget {
  const DummyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dummy Screen'),
      ),
      body: const Center(
        child: Text('This is a dummy screen!'),
      ),
    );
  }
}

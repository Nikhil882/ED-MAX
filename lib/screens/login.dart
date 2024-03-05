import 'homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'ot.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB0CFDF),
              Color(0xFFB0CFDF),
              Color(0xFF39A5EF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              // Added Expanded widget
              child: Stack(
                children: [
                  Image.asset('assets/Cloud.png'),
                  Container(
                    margin: EdgeInsets.fromLTRB(50, 200, 50, 0),
                    height: 500,
                    width: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(
                          100, 255, 255, 255), // Transparent glossy white
                    ),
                    child: Opacity(
                      opacity: 1.0, // Adjust the opacity as needed
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          const Text(
                            'Login...',
                            style: TextStyle(
                                fontFamily: 'Archive',
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                      // bottomLeft
                                      offset: Offset(-1.5, -1.5),
                                      color: Color(0xFF84ADC2)),
                                  Shadow(
                                      // bottomRight
                                      offset: Offset(1.5, -1.5),
                                      color: Color(0xFF84ADC2)),
                                  Shadow(
                                      // topRight
                                      offset: Offset(1.5, 1.5),
                                      color: Color(0xFF84ADC2)),
                                  Shadow(
                                      // topLeft
                                      offset: Offset(-1.5, 1.5),
                                      color: Color(0xFF84ADC2)),
                                ]),
                          ),
                          const Text(
                            'Fill in correct details',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 98, 127, 141)),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Email ID',
                                hintStyle: TextStyle(color: Color(0xFF84ADC2)),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon:
                                    Icon(Icons.email, color: Color(0xFF84ADC2)),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Color(0xFF84ADC2)),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Color(0xFF84ADC2),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color(0xFF84ADC2),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              obscureText: !_isPasswordVisible,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () => Get.to(const HomeScreen()),
                              child: const Text("Login"),
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     Get.to(()=> const HomeScreen());
                          //   },
                          //   child: Container(
                          //     width: 150,
                          //     height: 100,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(
                          //           300), // Adjust the radius as needed
                          //       image: DecorationImage(
                          //         image: AssetImage('assets/button.png'),
                          //         fit: BoxFit.contain, // or BoxFit.cover
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edmax/screens/homeScreen.dart';
import 'package:edmax/utils/colors.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/logo.jpg'),
                height: 200,
                width: 200,
                alignment: Alignment.center,
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    height: 450,
                    width: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(100, 112, 134, 146),
                    ),
                    child: Opacity(
                      opacity: 1.0,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                           Text(
                            'Login...',
                            style: TextStyle(
                              fontFamily: 'Archive',
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(-1.5, -1.5),
                                  color: backgroundColor,
                                ),
                                Shadow(
                                  offset: Offset(1.5, -1.5),
                                  color: backgroundColor,
                                ),
                                Shadow(
                                  offset: Offset(1.5, 1.5),
                                  color: backgroundColor,
                                ),
                                Shadow(
                                  offset: Offset(-1.5, 1.5),
                                  color: backgroundColor,
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'Fill in correct details',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Email ID',
                                hintStyle: TextStyle(color: Colors.blue.shade200),
                                fillColor: backgroundColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.email, color: Colors.blue.shade200),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.blue.shade200),
                                fillColor: backgroundColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.vpn_key, color: Colors.blue.shade200),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.blue.shade200,
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
                          SizedBox(height: 50),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const HomeScreen());
                            },
                            child: Container(
                              width: 140,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.transparent,
                                image: DecorationImage(
                                  image: AssetImage('assets/button.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

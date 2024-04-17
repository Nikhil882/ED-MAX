import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edmax/screens/admin/adminScreen.dart';
import 'package:edmax/screens/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edmax/screens/homeScreen.dart';
import 'package:edmax/utils/colors.dart';
import 'package:edmax/providers/user_provider.dart';
import 'package:edmax/resources/auth_methods.dart';
import 'package:edmax/resources/firestore_methods.dart';

bool isAdmin = false;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          backgroundColor: backgroundColor,
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void route() {
    User? user = _auth.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "admin") {
          isAdmin = true;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdminHomeScreen(),
            ),
          );
        } else if (documentSnapshot.get('role') == "parent" ||
            documentSnapshot.get('role') == "teacher") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else if (documentSnapshot.get('role') == "student") {
          isAdmin = true;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          print('Invalid Role');
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(email + password);
      route();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

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
              Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                height: 450,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(100, 112, 134, 146),
                ),
                child: Opacity(
                  opacity: 1.0,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email ID',
                            hintStyle:
                                TextStyle(color: Colors.blue.shade200),
                            fillColor: backgroundColor,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.email,
                                color: Colors.blue.shade200),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle:
                                TextStyle(color: Colors.blue.shade200),
                            fillColor: backgroundColor,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.vpn_key,
                                color: Colors.blue.shade200),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
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
                          setState(() {
                            _isLoading = true;
                          });
                          loginUser(_emailController.text,
                              _passwordController.text);
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
                      // Visibility(
                      //   maintainSize: true,
                      //   maintainAnimation: true,
                      //   maintainState: true,
                      //   visible: _isLoading,
                      //   child: const Loading(),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

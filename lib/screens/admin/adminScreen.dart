import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edmax/screens/pdf_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:edmax/resources/auth_methods.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatefulWidget {
  AdminHomeScreen({Key? key}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController mail = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController name = TextEditingController();

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  ElevatedButton(
                    child: Text("Add Students"),
                    onPressed: () => addStudents(context),
                  ),
                  ElevatedButton(
                    child: Text("Add Teacher"),
                    onPressed: () => null, // Placeholder onPressed handler
                  ),
                  ElevatedButton(
                    onPressed: () => Get.to(const PdfScreen()),
                    child: Text("Pdf Screen"),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: Text("Sign Out"),
              onPressed: () => AuthMethods().signOut(),
            ),
          ],
        ),
      ),
    );
  }

  void add() async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: mail.text, password: pass.text)
          .then((value) => {postDetailsToFirestore(mail.text, "student")})
          .catchError((e) {});
    }
  }

  // void addteach() async {
  //   if (_formKey.currentState!.validate()) {
  //     await _auth
  //         .createUserWithEmailAndPassword(email: mail.text, password: pass.text)
  //         .then((value) => {postDetailsToFirestore(mail.text, "teacher")})
  //         .catchError((e) {});
  //   }
  // }

  postDetailsToFirestore(String email, String role) async {
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('students');
    ref.doc(user!.uid).set({'email': mail.text, 'role': role, 'uid': user.uid});
  }

  void addStudents(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormBuilderTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: mail,
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                  // Add validators as needed
                ),
                SizedBox(height: 10),
                FormBuilderTextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: pass,
                  name: 'password',
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  // Add validators as needed
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      add();
                      debugPrint(_formKey.currentState!.value.toString());
                      // Perform your login logic here
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

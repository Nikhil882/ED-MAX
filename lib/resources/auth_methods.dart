import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:edmax/models/user.dart' as model;
import 'package:edmax/resources/storage_methods.dart';
import 'package:get/get.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<model.OurUser> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('students').doc(currentUser.uid).get();

    return model.OurUser.fromSnap(documentSnapshot);
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
       UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // await _firestore.collection("students").doc(cred.user!.uid).set({
        //   'uid': cred.user!.uid,
        //   'email': email,
        // });

        
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (err.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAndToNamed("/login");
  }
}

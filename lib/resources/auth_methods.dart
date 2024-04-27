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

  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAndToNamed("/login");
  }
}

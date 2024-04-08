import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  final String email;
  final String uid;
  final String name;



  const OurUser(
      {required this.name,
      required this.uid,
      required this.email,
      });


  static OurUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return OurUser(
      name: snapshot["name"],
      uid: snapshot["uid"],
      email: snapshot["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "email": email,
      };
}


import 'package:edmax/screens/teach/attendance.dart';
import 'package:edmax/screens/teach/attendance2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/colors.dart';

class Subjects extends StatefulWidget {
  const Subjects({Key? key}) : super(key: key);

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  var fire = FirebaseFirestore.instance;
  String sub = 'Subject1';
  String sub2 = 'Subject2';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.inner,
                  color: Colors.blue,
                  blurRadius: 100.0,
                  spreadRadius: 0.0,
                  offset: const Offset(0.0, 3.0,),
                ),
              ],
              color: backgroundColor1.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Attend1(),));
              },
              child: Text(
                sub,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.inner,
                  color: Colors.blue,
                  blurRadius: 100.0,
                  spreadRadius: 0.0,
                  offset: const Offset(0.0, 3.0,),
                ),
              ],
              color: backgroundColor1.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: GestureDetector(
              onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Attend2(),));

              },
              child: Text(
                sub2,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../utils/colors.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

Future<List<int>> fetchCurrentUserSubjects() async {
  List<int> subjects = [0, 0]; // Default values

  try {
    // Get the current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Access Firestore collection 'students' for the current user
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('students')
          .doc(user.uid)
          .get();

      // Check if the document exists and has 'subject1' and 'subject2' fields
      if (snapshot.exists) {
        // Extract 'subject1' and 'subject2' fields and store them in variables
        int subject1 = snapshot.get('subject1') ?? 0;
        int subject2 = snapshot.get('subject2') ?? 0;

        subjects = [subject1, subject2];
      }
    }
  } catch (error) {
    print('Error fetching subject data for current user: $error');
  }
  return subjects;
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  int subject1 = 0;
  int subject2 = 0;
  int total = 0;
  double totalAttendance = 0;
  List<double> subjectAttendance = [10, 10];

  @override
  void initState() {
    super.initState();
    fetchCurrentUserSubjects().then((subjects) {
      setState(() {
        subject1 = subjects[0];
        subject2 = subjects[1];
        updateSubjectAttendance();
        totalAttendance = (subject1 + subject2) / 20;
        dataMap = {
          'Attended': totalAttendance * 100,
          'Absent': (1 - totalAttendance) * 100,
        };
        total = subject1 + subject2;
      });
    });
  }

  void updateSubjectAttendance() {
    subjectAttendance = [subject1.toDouble(), subject2.toDouble()];
  }

  Map<String, double> dataMap = {
    'Attended': 10.0,
    'Absent': 30.0,
  };
  // Calculate total percentage here

  List<String> subjects = ['Subject1', 'Subject2'];
  // Example subjects
  // Example subject-wise attendance percentages

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    // Format the date using the 'dd MMMM yyyy' format
    String formattedDate = DateFormat('dd MMMM yyyy').format(now);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.inner,
                    color: Colors.blue,
                    blurRadius: 100.0,
                    spreadRadius: 0.0,
                    offset: const Offset(
                      0.0,
                      3.0,
                    ),
                  ),
                ],
                color: backgroundColor1.withOpacity(0.5),
                // border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                '$formattedDate',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.white,
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.inner,
                    color: Colors.blue,
                    blurRadius: 100.0,
                    spreadRadius: 0.0,
                    offset: const Offset(
                      0.0,
                      5.0,
                    ),
                  ),
                ],

                color: backgroundColor1.withOpacity(0.6),
                // border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: PieChart(
                  dataMap: dataMap,
                  colorList: [Colors.greenAccent, Colors.red],
                  chartType: ChartType.ring,
                  chartRadius: MediaQuery.of(context).size.width / 3.5,
                  // centerText: "${totalPercentage.toStringAsFixed(1)}%",
                  centerWidget: Text(
                    textAlign: TextAlign.center,
                    "$total out of \n20",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 0.1,
                      shadows: [
                        Shadow(
                          color: Colors.white,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),

                  legendOptions: LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValuesOutside: true,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValueBackground: true,
                    chartValueBackgroundColor: Colors.white,
                    chartValueStyle: TextStyle(
                        color: backgroundColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Subject-wise Attendance:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 8.0), // Add margin vertically
                    child: ListTile(
                      tileColor: backgroundColor1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      title: Text(
                        subjects[index],
                        style: TextStyle(
                          color: Colors.white,

                        ),
                      ),
                      subtitle: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.normal,
                              color: Colors.lightBlueAccent.withOpacity(0.4),
                              blurRadius: 30.0,
                              spreadRadius: 0.0,
                              offset: const Offset(
                                0.0,
                                3.0,
                              ),
                            ),
                          ],
                        ),
                        child: LinearPercentIndicator(
                          animation: true,
                          barRadius: Radius.circular(10),
                          width: MediaQuery.of(context).size.width - 73,
                          lineHeight: 20.0,
                          percent: subjectAttendance[index] / 10,
                          progressColor: Colors.cyanAccent.shade400,
                          backgroundColor: Colors.lightBlueAccent.shade700,
                          center: Text(
                            '${(subjectAttendance[index] * 10).toStringAsFixed(1)}%',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.white,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

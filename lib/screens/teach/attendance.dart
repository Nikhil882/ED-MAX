import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/colors.dart';

class Attend1 extends StatefulWidget {
  const Attend1({Key? key}) : super(key: key);

  @override
  State<Attend1> createState() => _Attend1State();
}

class _Attend1State extends State<Attend1> {
  // List to maintain the toggle state for each student
  late List<bool> isSelectedList;
  late AsyncSnapshot<QuerySnapshot> _snapshot;

  @override
  void initState() {
    super.initState();
    // Initialize isSelectedList to an empty list
    isSelectedList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Teacher Attendance',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('students')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                _snapshot = snapshot; // Storing snapshot for later use
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<DocumentSnapshot> students = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (BuildContext context, int index) {
                    String userName = 'No email';
                    String userEmail = '';
                    try {
                      // Attempt to access the 'email' field and convert it to a string
                      var email = (students[index].data() as Map<String,
                          dynamic>?)?['email'] ?? '';
                      if (email != null) {
                        userName = email.toString();
                        userEmail = email.toString();
                      }
                    } catch (e) {
                      // Handle any potential exceptions (e.g., if 'email' is null)
                      print('Error: $e');
                    }
                    // Initialize isSelectedList for each list tile if it's not initialized yet
                    if (isSelectedList.length <= index) {
                      isSelectedList.add(false);
                    }
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurStyle: BlurStyle.inner,
                            blurRadius: 100.0,
                            color: Colors.blue,
                            spreadRadius: 0.0,
                            offset: const Offset(0.0, 3.0),
                          ),
                        ],
                        color: backgroundColor1.withOpacity(0.5),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      margin: EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 10.0),
                      child: ListTile(
                        tileColor: backgroundColor1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        // Subtitle with Switch widget for Present and Absent
                        title: Row(
                          children: [
                            Text(
                              userName,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Switch(
                              value: isSelectedList[index],
                              onChanged: (bool value) {
                                setState(() {
                                  isSelectedList[index] = value;
                                });
                              },
                              activeColor: Colors.greenAccent,
                              inactiveTrackColor: Colors.red,
                              inactiveThumbColor: Colors.white,
                              trackOutlineColor: MaterialStateProperty.all(
                                  Colors.white),
                              trackOutlineWidth: MaterialStateProperty.all(0.5),
                            ),
                            Text(
                              isSelectedList[index] ? 'Present' : 'Absent',
                              style: TextStyle(
                                color: isSelectedList[index] ? Colors
                                    .greenAccent : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
              ),
              onPressed: () {
                for (int i = 0; i < isSelectedList.length; i++) {
                  if (isSelectedList[i]) {
                    // Get the email of the user at index i
                    String userEmail = (_snapshot.data!.docs[i].data() as Map<
                        String,
                        dynamic>)?['email'] ?? '';
                    // Call the updateFirestore method to increment present count
                    updateFirestore(userEmail);
                    Navigator.pop(context);
                  }
                }
              },
              child: Text(
                'SUBMIT',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateFirestore(String email) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('email', isEqualTo: email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot document = snapshot.docs.first;
        int count = (document.data() as Map<String, dynamic>).containsKey(
            'subject1')
            ? document.get('subject1')
            : 0;
        await document.reference.set({
          'subject1': count + 1,
        }, SetOptions(
            merge: true)); // Use merge option to update existing fields without overwriting
      } else {
        // If the document doesn't exist, create it with subject1 set to 1
        await FirebaseFirestore.instance.collection('students').doc(email).set({
          'email': email,
          'subject1': 1,
        });
      }
    } catch (e) {
      print('Error updating Firestore: $e');
    }
  }
}
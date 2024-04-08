import 'package:edmax/utils/colors.dart';
import 'package:edmax/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edmax/resources/auth_methods.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _controller = TextEditingController();
  String name = '';
  String? error; // To store any error message

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('students')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final userData = userSnap.data();
      if (userData != null) {
        setState(() {
          name = userData['name'] ?? ''; // Set email if available
        });

        // name = userSnap.data()?['email'];
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/paws_logo.jpeg'),
            ),
            const SizedBox(height: 16.0),
             Text(
              name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Third Year',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            buildInfoCard('Roll No', '22US17683CM003'),
            buildInfoCard('Email', 'JAY@example.com'),
            buildInfoCard('Phone', '123456789'),
            buildInfoCard('Location', 'City, Country'),
            const SizedBox(height: 16.0),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
              ),
              onPressed: () async {
                // Get current user's ID
                final user = FirebaseAuth.instance.currentUser;
                if (user == null) {
                  // Handle case where no user is signed in (optional)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please sign in to edit your profile'),
                    ),
                  );
                  return;
                }

                final userId = user.uid;

                // Get user input for name
                final name = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final TextEditingController _nameController = TextEditingController();
                    return AlertDialog(
                      title: const Text('Edit Your Name'),
                      content: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Enter Name'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), // Close dialog
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Validate name (optional)
                            if (_nameController.text.isNotEmpty) {
                              Navigator.pop(context, _nameController.text); // Return name
                            } else {
                              // Show error message (optional)
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a name'),
                                ),
                              );
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );

                if (name != null && name.isNotEmpty) {
                  // Update name in Firestore for the current user
                  final firestore = FirebaseFirestore.instance;
                  final docRef = firestore.collection('students').doc(userId);
                  await docRef.update({
                    'name': name,
                    // Add other relevant fields for the student document (optional)
                  });

                  // Show success message (optional)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Name "$name" updated successfully!',
                      style: TextStyle(color: Colors.black),),
                    ),
                  );
                }
              },
              child: const Text('Edit Profile',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),


                // Handle button press, e.g., navigate to edit profile page

          ],
        ),
      ),
      // bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget buildInfoCard(String label, String value) {
    return Card(
      color: backgroundColor2,
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style:  TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade200,
              ),
            ),
            Text(
              value,
              style:  TextStyle(
                fontSize: 16.0,
                color: Colors.blue.shade100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

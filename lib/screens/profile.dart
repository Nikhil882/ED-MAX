import 'package:edmax/screens/bottom_nav.dart';
import 'package:edmax/utils/colors.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(ProfileApp());
// }
//
// class ProfileApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: ProfilePage(),
//     );
//   }
// }

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
            const Text(
              'Jay Mhatre',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Third Year',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
            buildInfoCard('Roll No', '22US17683CM003'),
            buildInfoCard('Email', 'JAY@example.com'),
            buildInfoCard('Phone', '123456789'),
            buildInfoCard('Location', 'City, Country'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle button press, e.g., navigate to edit profile page
              },
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget buildInfoCard(String label, String value) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16.0,
                color: backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

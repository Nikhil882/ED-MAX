import 'side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("ED-MAX"),
        centerTitle: true,
        // automaticallyImplyLeading: false,
      ),
      drawer: const SideMenu(),
      body: Column(
        children: [
          const Text('ffxh'),
          ElevatedButton(onPressed: () => Get.to(Login()),
          child: const Text('vjnbkb'),)
        ],
      ),

    );
  }
}

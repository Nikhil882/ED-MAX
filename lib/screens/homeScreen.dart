import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('xgxh'),
      ),
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

import 'package:flutter/material.dart';

final items = [
  const Icon(Icons.people, size: 30),
  const Icon(Icons.chat, size: 30),
  const Icon(Icons.home, size: 30),
  const Icon(Icons.assignment, size: 30),
  const Icon(Icons.assignment_turned_in, size: 30),
];
int index = 2; // Default index set to Home

// Add images for the carousel
final List<String> carouselImages = [
  'assets/Cloud.png',
  'assets/button.png',
  'image3.jpg',
];

List<String> questions = [
  "1. What is dnfksn?",
  "2. What is msldfnls?",

];
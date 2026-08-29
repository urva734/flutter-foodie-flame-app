import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // <-- This line is important

void main() {
  runApp(const FoodieFlameApp());
}

class FoodieFlameApp extends StatelessWidget {
  const FoodieFlameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodie Flame',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      home: const HomeScreen(), // <-- This connects to home_screen.dart
    );
  }
}
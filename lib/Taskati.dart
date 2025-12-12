import 'package:flutter/material.dart';
import 'package:taskati/screens/splashscreen.dart';  // ← المهم ده

class Taskati extends StatelessWidget {
  const Taskati({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lankago/features/Explore/presentation/pages/explore_page.dart';
import 'package:lankago/features/home/presentation/pages/home_page.dart';
import 'package:lankago/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

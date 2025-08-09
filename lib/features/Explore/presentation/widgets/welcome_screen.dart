import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Select a district to explore!",
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}

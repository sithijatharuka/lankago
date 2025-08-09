import 'package:flutter/material.dart';

class LoginSubtitle extends StatelessWidget {
  const LoginSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Explore Sri Lanka Smartly',
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.5,
      ),
    );
  }
}

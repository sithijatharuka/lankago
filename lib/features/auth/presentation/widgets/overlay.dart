import 'package:flutter/material.dart';

class CustomOverlay extends StatelessWidget {
  const CustomOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(
              0.7,
            ), // Increased opacity for darker overlay
            Colors.black.withOpacity(
              0.7,
            ), // Increased opacity for darker overlay
          ],
        ),
      ),
    );
  }
}

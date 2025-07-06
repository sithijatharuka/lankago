import 'package:flutter/material.dart';

class CurrentLocationSection extends StatelessWidget {
  const CurrentLocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, color: Colors.blue, size: 20),
        SizedBox(width: 8),
        Text(
          'Current Location: Colombo',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }
}

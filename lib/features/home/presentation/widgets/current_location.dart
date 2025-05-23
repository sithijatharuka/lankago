import 'package:flutter/material.dart';

Row currentLocationSection() {
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

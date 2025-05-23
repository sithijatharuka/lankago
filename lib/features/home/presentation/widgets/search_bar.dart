import 'package:flutter/material.dart';

Container searchBar() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(Icons.search, color: Colors.grey[600]),
        SizedBox(width: 12),
        Text(
          'Search destinations...',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:lankago/features/TripPlanner/presentation/pages/trip_planner.dart';

GestureDetector planMyTripButton(BuildContext context) {
  return GestureDetector(
    onTap:() {
      Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TripPlanner()),
              );
    },
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            child: Icon(Icons.chat_bubble_outline, color: Colors.white, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ask Lanka',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Your travel assistant',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ],
      ),
    ),
  );
}

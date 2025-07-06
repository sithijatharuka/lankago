import 'package:flutter/material.dart';

Container buildDailyPlanner() {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFF9FAFB),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE5E7EB)),
    ),
    child: ExpansionTile(
      title: Text('Day 1', style: TextStyle(fontWeight: FontWeight.w600)),
      trailing: Icon(Icons.expand_more),
      children: <Widget>[
        ListTile(title: Text('Morning')),
        ListTile(title: Text('Afternoon')),
        ListTile(title: Text('Evening')),
      ],
    ),
  );
}

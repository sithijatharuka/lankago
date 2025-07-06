import 'package:flutter/material.dart';

class DailyPlanner extends StatelessWidget {
  const DailyPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: ExpansionTile(
        title: const Text(
          'Day 1',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.expand_more),
        children: const <Widget>[
          ListTile(title: Text('Morning')),
          ListTile(title: Text('Afternoon')),
          ListTile(title: Text('Evening')),
        ],
      ),
    );
  }
}

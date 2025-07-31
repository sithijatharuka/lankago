import 'package:flutter/material.dart';

class DailyPlanner extends StatelessWidget {
  final Map<String, dynamic> itinerary;

  const DailyPlanner({required this.itinerary, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: itinerary.entries.map((entry) {
        final day = entry.key;
        final activities = entry.value as Map<String, dynamic>;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE5E7EB)),
          ),
          child: ExpansionTile(
            title: Text(
              day,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: Icon(Icons.expand_more),
            children: activities.entries.map((e) {
              return ListTile(
                leading: Icon(Icons.schedule),
                title: Text('${e.key}'),
                subtitle: Text('${e.value}'),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
import 'package:flutter/material.dart';

class DetailsHeader extends StatelessWidget {
  final Map<String, dynamic> place;
  final Map<String, dynamic> details;

  const DetailsHeader({super.key, required this.place, required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Location: ${place['location'] ?? ''}"),
        const SizedBox(height: 8),
        Text("Duration: ${details['duration'] ?? 'N/A'}"),
        Text("Cost: ${details['estimated_cost'] ?? 'N/A'}"),
        Text("Difficulty: ${details['difficulty'] ?? 'N/A'}"),
        Text("Category: ${details['category'] ?? 'N/A'}"),
        const SizedBox(height: 16),
      ],
    );
  }
}

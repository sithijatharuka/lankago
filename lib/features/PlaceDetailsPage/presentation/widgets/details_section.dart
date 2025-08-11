import 'package:flutter/material.dart';

class DetailsSection extends StatelessWidget {
  final String title;
  final String content;

  const DetailsSection({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    if (content.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 6),
          Text(content, style: const TextStyle(fontSize: 15, height: 1.4)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

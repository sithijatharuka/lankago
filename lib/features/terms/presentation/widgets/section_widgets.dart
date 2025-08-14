import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final String content;

  const SectionWidget({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(content, style: const TextStyle(fontSize: 14, height: 1.5)),
        const SizedBox(height: 16),
      ],
    );
  }
}

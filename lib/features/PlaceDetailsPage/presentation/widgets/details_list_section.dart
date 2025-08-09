import 'package:flutter/material.dart';

class DetailsListSection extends StatelessWidget {
  final String title;
  final List<dynamic>? items;

  const DetailsListSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items == null || items!.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        ...items!.map((item) => Text("• $item")).toList(),
        const SizedBox(height: 16),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lankago/features/home/presentation/widgets/popular_adv_item.dart';

class AdventureList extends StatelessWidget {
  final List<Map<String, dynamic>> adventures;

  const AdventureList({super.key, required this.adventures});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: adventures.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final adventure = adventures[index];
        return PopularAdvItem(
          title: adventure['title'] ?? 'Unknown',
          subtitle: adventure['subtitle'] ?? '',
          emoji: adventure['emoji'],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lankago/features/home/presentation/widgets/popular_adv_item.dart';

class AdventureList extends StatelessWidget {
  const AdventureList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 2,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0) {
          return PopularAdvItem(
            title: 'Climbing Pidurangala Rock',
            subtitle: 'Peaceful meditation spot',
            imageUrl:
                'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=200&h=200&fit=crop',
          );
        } else {
          return PopularAdvItem(
            title: 'Climbing Pidurangala Rock',
            subtitle: 'Peaceful meditation spot',
            imageUrl:
                'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=200&h=200&fit=crop',
          );
        }
      },
    );
  }
}

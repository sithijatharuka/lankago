import 'package:flutter/material.dart';
import 'package:lankago/features/home/presentation/widgets/popular_adv_item.dart';

ListView adventureList() {
  return ListView.separated(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: 2,
    separatorBuilder: (context, index) => SizedBox(height: 12),
    itemBuilder: (context, index) {
      if (index == 0) {
        return popularAdvItem(
          'Climbing Pidurangala Rock',
          'Peaceful meditation spot',
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=200&h=200&fit=crop',
        );
      } else {
        return popularAdvItem(
          'Bird-Watching in Bundala National Park',
          'Historic rock carvings',
          'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=200&h=200&fit=crop',
        );
      }
    },
  );
}

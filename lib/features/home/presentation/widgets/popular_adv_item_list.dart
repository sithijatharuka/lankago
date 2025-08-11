import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lankago/features/PlaceDetailsPage/presentation/pages/place_details_page.dart';

class PopularAdvItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String emoji;

  const PopularAdvItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => PlaceDetailsPage(
                  place: {'title': title},
                  accentColor: Colors.blue,
                ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(emoji, style: TextStyle(fontSize: 30)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

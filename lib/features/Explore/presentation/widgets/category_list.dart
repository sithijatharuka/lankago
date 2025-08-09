import 'package:flutter/material.dart';
import 'package:lankago/features/PlaceDetailsPage/presentation/pages/place_details_page.dart';

class CategoryList extends StatelessWidget {
  final String title;
  final List<dynamic> items;

  const CategoryList({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ...items.map((place) {
          return Card(
            child: ListTile(
              title: Text(place['title']),
              subtitle: Text(place['description']),
              trailing: Text(place['type']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => PlaceDetailsPage(
                          place: {
                            'title': place['title'],
                            'description': place['description'],
                            'type': place['type'],
                            'location': place['location'],
                          },
                          accentColor: Colors.blue,
                        ),
                  ),
                );
              },
            ),
          );
        }),
        const SizedBox(height: 12),
      ],
    );
  }
}

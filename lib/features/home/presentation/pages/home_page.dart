import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:go_router/go_router.dart';
import 'package:lankago/ask.dart';
import 'package:lankago/features/home/presentation/widgets/button.dart';
import 'package:lankago/features/home/presentation/widgets/featured_destination_card.dart';
import 'package:lankago/features/home/presentation/widgets/home_app_bar.dart';
import 'package:lankago/features/home/presentation/widgets/popular_adv_item.dart';
import 'package:lankago/features/home/presentation/widgets/current_location.dart';
import 'package:lankago/features/home/presentation/widgets/heading_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Featured destinations loaded from JSON file
  List<Map<String, dynamic>> featuredDestinations = [];

  // Popular adventures list and status
  List<Map<String, dynamic>> popularAdventures = [];
  String adventureResponse = "Loading popular adventures...";

  @override
  void initState() {
    super.initState();
    loadFeaturedDestinations();
    fetchPopularAdventures();
  }

  Future<void> loadFeaturedDestinations() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/featured_places.json',
      );
      final List<dynamic> jsonList = jsonDecode(jsonString);
      setState(() {
        featuredDestinations = jsonList.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      // handle error if needed
      setState(() {
        featuredDestinations = [];
      });
    }
  }

  void fetchPopularAdventures() async {
    setState(() {
      adventureResponse = "Loading popular adventures...";
      popularAdventures = [];
    });

    try {
      final result = await askGemini('''
  Give me a list of 5 popular adventure activities in Sri Lanka in JSON format.
  Each item should have "title", "subtitle", and "emoji". Return only JSON array.
  Example:
  [
    {
      "title": "Climbing Pidurangala Rock",
      "subtitle": "Peaceful meditation spot",
      "emoji": "🏞️"
    },
    ...
  ]
  ''');

      final cleaned =
          result.replaceAll('```json', '').replaceAll('```', '').trim();

      final List<dynamic> decoded = jsonDecode(cleaned);
      final List<Map<String, dynamic>> adventures =
          decoded
              .map(
                (item) => {
                  'title': item['title'],
                  'subtitle': item['subtitle'],
                  'emoji': item['emoji'],
                },
              )
              .toList();

      setState(() {
        popularAdventures = adventures;
        adventureResponse = "Loaded popular adventures";
      });
    } catch (e) {
      setState(() => adventureResponse = "Error loading adventures");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeAppBar(context, user),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CurrentLocationSection(),
            const HeadingText(text: 'Featured Destinations'),
            featuredCards(),
            const HeadingText(text: 'Popular Adventures in Sri Lanka'),
            popularAdventures.isNotEmpty
                ? AdventureList(adventures: popularAdventures)
                : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: Text(adventureResponse)),
                ),
            CustomButton(
              label: 'Plan My Trip',
              onPressed: () {
                context.pushNamed('/planTrips');
              },
            ),
          ],
        ),
      ),
    );
  }

  SizedBox featuredCards() {
    return SizedBox(
      height: 200,
      child:
          featuredDestinations.isNotEmpty
              ? ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: featuredDestinations.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final dest = featuredDestinations[index];
                  return FeaturedCard(
                    title: dest['title'],
                    rating: (dest['rating'] as double).toStringAsFixed(1),
                    imageUrl: dest['imageUrl'],
                  );
                },
              )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}

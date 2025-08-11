import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lankago/ask.dart';
import 'package:lankago/core/widgets/weather_card.dart';
import 'package:lankago/features/home/presentation/widgets/button.dart';
import 'package:lankago/features/profile/presentation/profile_page.dart';
import 'package:lankago/features/home/presentation/widgets/alert_card_section.dart';
import 'package:lankago/features/home/presentation/widgets/current_location.dart';
import 'package:lankago/features/home/presentation/widgets/featured_destination_card.dart';
import 'package:lankago/features/home/presentation/widgets/heading_text.dart';
import 'package:lankago/features/home/presentation/widgets/plan_my_trip_button.dart';
import 'package:lankago/features/home/presentation/widgets/popular_adv_item_list.dart';
import 'package:lankago/core/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Featured destination fields
  String response = "";
  String? title;
  double? rating;
  String? imageUrl;

  // Popular adventures list and status
  List<Map<String, dynamic>> popularAdventures = [];
  String adventureResponse = "";

  // Bottom nav index
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    sendPrompt(); // Fetch featured destination
    fetchPopularAdventures(); // Fetch adventure list
  }

  void sendPrompt() async {
    setState(() {
      response = "Thinking...";
      title = null;
      rating = null;
      imageUrl = null;
    });

    try {
      final result = await askGemini(
        '''Give me one featured travel destination in Sri Lanka kanthale. Return it as JSON with:
{
  "title": "string",
  "rating": "float (1.0 to 5.0)",
  "imageUrl": "string (image of location)"
}
''',
      );

      final cleaned =
          result.replaceAll('```json', '').replaceAll('```', '').trim();

      final decoded = jsonDecode(cleaned);
      setState(() {
        title = decoded['title'];
        rating = double.tryParse(decoded['rating'].toString());
        imageUrl = decoded['imageUrl'];
        response = "Loaded";
      });
    } catch (e) {
      setState(() => response = "Error: $e");
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
      setState(() => adventureResponse = "Error");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'LankaGo',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => context.pushNamed('/profile'),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  user?.photoURL ?? 'https://via.placeholder.com/150',
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            const CurrentLocationSection(),
            WeatherCard(
              location: 'location',
              temperature: '60',
              weatherDescription: 'weatherDescription',
              weatherIcon: Icons.wb_sunny,
            ),

            const HeadingText(text: 'Featured Destinations'),

            // (title != null && rating != null && imageUrl != null)
            //     ? FeaturedCard(
            //       title: title!,
            //       rating: rating!.toStringAsFixed(1),
            //       imageUrl: imageUrl!,
            //     )
            //     : Text(response),
            const AlertCardSection(),

            const HeadingText(text: 'Popular Adventures in Sri Lanka'),

            // popularAdventures.isNotEmpty
            //     ? AdventureList(adventures: popularAdventures)
            //     : Text(adventureResponse),
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

  BottomNavigationBar bottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Trip Planner'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

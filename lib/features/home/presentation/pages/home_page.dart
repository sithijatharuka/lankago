import 'package:flutter/material.dart';
import 'package:lankago/features/home/presentation/widgets/button.dart';
import 'package:lankago/features/profile/presentation/profile_page.dart';
import 'package:lankago/features/home/presentation/widgets/alert_card_section.dart';
import 'package:lankago/features/home/presentation/widgets/current_location.dart';
import 'package:lankago/features/home/presentation/widgets/featured_destination_card.dart';
import 'package:lankago/features/home/presentation/widgets/heading_text.dart';
import 'package:lankago/features/home/presentation/widgets/plan_my_trip_button.dart';
import 'package:lankago/features/home/presentation/widgets/popular_adv_item_list.dart';
import 'package:lankago/features/home/presentation/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: Colors.white,
        // bottomNavigationBar: bottomNavBar(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
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
              margin: EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/57886706?v=4',
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                CustomSearchBar(),

                SizedBox(height: 20),

                // Current Location
                CurrentLocationSection(),

                SizedBox(height: 30),

                // Featured Destinations
                HeadingText(text: 'Featured Destinations'),

                SizedBox(height: 16),

                // Featured destination card
                FeaturedCard(),

                SizedBox(height: 20),

                // Alerts and Experiences buttons
                AlertCardSection(),

                SizedBox(height: 30),

                // Popular Adventures
                HeadingText(text: 'Popular Adventures in Sri Lanka'),

                SizedBox(height: 16),

                // Adventure List
                AdventureList(),

                SizedBox(height: 30),

                // Plan My Trip Button
                CustomButton(
                  onPressed: () {
                    print('Button Pressed');
                  },
                ),

                SizedBox(height: 20),

                // Ask Lanka Section
                PlanMyTripButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBar bottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: _selectedIndex,
      onTap: (value) => _onItemTapped,
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

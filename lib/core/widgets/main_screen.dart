import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:lankago/features/explore/presentation/pages/explore_page.dart';
import 'package:lankago/features/my_trips/presentation/pages/my_trips_page.dart';
import 'package:lankago/features/trip_planner/presentation/pages/trip_planner.dart';
import 'package:lankago/features/home/presentation/pages/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomePage(),
    ExplorePage(),
    TripPlanner(),
    MyTripsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 65,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          selectedFontSize: 12,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: HeroIcon(
                HeroIcons.home,
                style: HeroIconStyle.micro,
                size: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: HeroIcon(
                HeroIcons.map,
                style: HeroIconStyle.micro,
                size: 30,
              ),
              label: 'Trip Planner',
            ),
            BottomNavigationBarItem(
              icon: HeroIcon(
                HeroIcons.bookmark,
                style: HeroIconStyle.micro,
                size: 30,
              ),
              label: 'Trips',
            ),
          ],
        ),
      ),
    );
  }
}

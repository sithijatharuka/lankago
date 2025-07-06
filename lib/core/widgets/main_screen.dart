import 'package:flutter/material.dart';
import 'package:lankago/features/Explore/presentation/pages/explore_page.dart';
import 'package:lankago/features/MyTrips/presentation/pages/my_trips_page.dart';
import 'package:lankago/features/TripPlanner/presentation/pages/trip_planner.dart';
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Trip Planner'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Trips'),
        ],
      ),
    );
  }
}

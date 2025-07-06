import 'package:flutter/material.dart';
import 'package:lankago/features/my_trips/presentation/widgets/floating_button.dart';
import 'package:lankago/features/my_trips/presentation/widgets/trip_card.dart';
import 'package:lankago/features/trip_planner/presentation/pages/trip_planner.dart';
import 'package:lankago/features/home/presentation/widgets/search_bar.dart';

class MyTripsPage extends StatelessWidget {
  const MyTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Your Trips',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 15,
          children: [
            // Search Bar
            searchBar(),
            // Trip List
            Expanded(
              child: ListView(
                children: const [
                  TripCard(
                    destination: 'Ella, Sri Lanka',
                    tripName: 'Family Adventure 2025',
                    dates: 'July 5 - July 10, 2025',
                    peopleCount: 3,
                    status: TripStatus.upcoming,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: buildFloatingButton(context),
    );
  }
}

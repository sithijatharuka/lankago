import 'package:flutter/material.dart';
import 'package:lankago/features/my_trips/presentation/widgets/trip_card.dart';

class UpcomingTrips extends StatelessWidget {
  const UpcomingTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        TripCard(
          destination: 'Ella, Sri Lanka',
          tripName: 'Family Adventure 2025',
          dates: 'July 5 - July 10, 2025',
          peopleCount: 3,
          status: TripStatus.upcoming,
        ),
      ],
    );
  }
}

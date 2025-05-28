import 'package:flutter/material.dart';
import 'package:lankago/features/TripPlanner/presentation/pages/trip_planner.dart';

FloatingActionButton buildFloatingButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      // Handle add new trip
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => TripPlanner()));
    },
    backgroundColor: Colors.red[500],

    child: const Icon(Icons.add, color: Colors.white, size: 32),
  );
}

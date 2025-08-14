import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lankago/core/services/trip_service.dart';
import 'package:lankago/features/my_trips/presentation/widgets/trip_card.dart';
import 'package:lankago/features/trip_planner/presentation/pages/trip_planner.dart';

class MyTrips extends StatelessWidget {
  const MyTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'My Trips',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.blue, size: 24),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TripPlanner()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestoreService.getTripsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingState();
            }

            if (snapshot.hasError) {
              return _buildErrorState();
            }

            final trips = snapshot.data?.docs ?? [];

            if (trips.isEmpty) {
              return _buildEmptyState(context);
            }

            // Sort all trips by start date ascending
            trips.sort((a, b) {
              final aDate = (a.data()['startDate'] as Timestamp).toDate();
              final bDate = (b.data()['startDate'] as Timestamp).toDate();
              return aDate.compareTo(bDate);
            });

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  trips.map((trip) => _buildTripCard(trip.data())).toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTripCard(Map<String, dynamic> tripData) {
    return TripCard(
      tripName: tripData['tripName'] ?? 'Unnamed Trip',
      district: tripData['district'] ?? 'Unknown Location',
      startDate: (tripData['startDate'] as Timestamp).toDate(),
      endDate: (tripData['endDate'] as Timestamp).toDate(),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
            const SizedBox(height: 16),
            const Text(
              'Something went wrong',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              'Unable to load your trips',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(Icons.flight, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 24),
            const Text(
              'No trips yet!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Create your first trip and start exploring',
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TripPlanner()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Plan Your First Trip'),
            ),
          ],
        ),
      ),
    );
  }
}

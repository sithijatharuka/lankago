import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lankago/core/services/trip_service.dart';
import 'package:lankago/features/my_trips/presentation/widgets/trip_card.dart';

class UpcomingTrips extends StatelessWidget {
  const UpcomingTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Trips',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              color: Colors.black,
              size: 26,
            ),
            onPressed: () {
              context.go('/planTrips');
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50.withOpacity(0.3), Colors.white],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: firestoreService.getTripsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildLoadingState();
              }

              if (snapshot.hasError) {
                return _buildErrorState(snapshot.error.toString());
              }

              final trips = snapshot.data?.docs ?? [];

              if (trips.isEmpty) {
                return _buildEmptyState(context);
              }

              // Separate upcoming and past trips
              final now = DateTime.now();
              final upcomingTrips =
                  <QueryDocumentSnapshot<Map<String, dynamic>>>[];
              final pastTrips = <QueryDocumentSnapshot<Map<String, dynamic>>>[];

              for (final trip in trips) {
                final tripData = trip.data();
                final endDate = (tripData['endDate'] as Timestamp).toDate();

                if (endDate.isAfter(now)) {
                  upcomingTrips.add(trip);
                } else {
                  pastTrips.add(trip);
                }
              }

              // Sort trips by start date
              upcomingTrips.sort((a, b) {
                final aDate = (a.data()['startDate'] as Timestamp).toDate();
                final bDate = (b.data()['startDate'] as Timestamp).toDate();
                return aDate.compareTo(bDate);
              });

              pastTrips.sort((a, b) {
                final aDate = (a.data()['startDate'] as Timestamp).toDate();
                final bDate = (b.data()['startDate'] as Timestamp).toDate();
                return bDate.compareTo(aDate); // Reverse order for past trips
              });

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Statistics Cards
                  _buildStatsSection(upcomingTrips.length, pastTrips.length),

                  const SizedBox(height: 24),

                  // Upcoming Trips Section
                  if (upcomingTrips.isNotEmpty) ...[
                    _buildSectionHeader(
                      'Upcoming Adventures',
                      '${upcomingTrips.length} trip${upcomingTrips.length != 1 ? 's' : ''}',
                      Colors.blue.shade600,
                      Icons.upcoming_rounded,
                    ),
                    const SizedBox(height: 12),
                    ...upcomingTrips.map((trip) => _buildTripCard(trip.data())),
                    const SizedBox(height: 24),
                  ],

                  // Past Trips Section
                  if (pastTrips.isNotEmpty) ...[
                    _buildSectionHeader(
                      'Past Adventures',
                      '${pastTrips.length} trip${pastTrips.length != 1 ? 's' : ''}',
                      Colors.grey.shade600,
                      Icons.history_rounded,
                    ),
                    const SizedBox(height: 12),
                    ...pastTrips.map((trip) => _buildTripCard(trip.data())),
                  ],

                  const SizedBox(height: 32),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(int upcomingCount, int pastCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Upcoming',
              upcomingCount.toString(),
              Colors.blue.shade600,
              Icons.flight_takeoff_rounded,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Total',
              (upcomingCount + pastCount).toString(),
              Colors.orange.shade600,
              Icons.explore_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String count,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.1), width: 1),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            count,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    String subtitle,
    Color color,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
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
    return Container(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue.shade600),
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading your adventures...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: Colors.red.shade400,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Oops! Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Unable to load your trips right now',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // Trigger rebuild to retry
            },
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade100, Colors.blue.shade50],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              Icons.flight_rounded,
              size: 64,
              color: Colors.blue.shade400,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No trips yet!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your adventure awaits. Create your first trip and start exploring!',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to create trip page
            },
            icon: const Icon(Icons.add_rounded),
            label: const Text('Plan Your First Trip'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
            ),
          ),
        ],
      ),
    );
  }
}

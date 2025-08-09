import 'package:flutter/material.dart';
import 'package:lankago/features/my_trips/presentation/widgets/trip_card.dart';
import 'package:lankago/features/my_trips/presentation/widgets/empty_state.dart';
import 'package:lankago/features/my_trips/presentation/widgets/plan_trip_fab.dart';
import 'package:lankago/features/my_trips/presentation/widgets/upcoming_trips.dart';
import 'package:lankago/features/trip_planner/presentation/pages/trip_planner.dart';

class MyTripsPage extends StatefulWidget {
  const MyTripsPage({super.key});

  @override
  State<MyTripsPage> createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Trips'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Ongoing'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const UpcomingTrips(),
          const EmptyState(message: 'No Ongoing Trips'),
          const EmptyState(message: 'No Completed Trips'),
        ],
      ),
      floatingActionButton: PlanTripFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TripPlanner()),
          );
        },
      ),
    );
  }
}

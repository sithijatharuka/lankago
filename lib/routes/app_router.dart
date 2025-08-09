import 'package:go_router/go_router.dart';
import 'package:lankago/features/profile/presentation/profile_page.dart';
import 'package:lankago/features/trip_planner/presentation/pages/trip_planner.dart';
import 'package:lankago/features/alert/presentation/pages/alert_page.dart';
import 'package:lankago/features/auth/presentation/pages/login_page.dart';
import 'package:lankago/core/widgets/main_screen.dart';

final router = GoRouter(
  routes: [
    // The login page route; intended to be shown only once during user authentication
    GoRoute(name: '/', path: '/', builder: (context, state) => LoginPage()),
    // home Page
    GoRoute(
      name: '/home',
      path: '/home',
      builder: (context, state) => MainScreen(),
    ),
    GoRoute(
      name: '/alerts',
      path: '/alerts',
      builder: (context, state) => const AlertPage(),
    ),
    GoRoute(
      name: '/experiences',
      path: '/experiences',
      builder: (context, state) => const AlertPage(),
    ),
    GoRoute(
      name: '/planTrips',
      path: '/planTrips',
      builder: (context, state) => const TripPlanner(),
    ),
    GoRoute(
      name: '/profile',
      path: '/profile',
      builder: (context, state) => ProfilePage(),
    ),
  ],
);

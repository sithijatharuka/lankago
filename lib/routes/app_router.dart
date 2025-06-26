import 'package:go_router/go_router.dart';
import 'package:lankago/features/alert/presentation/pages/alert_page.dart';
import 'package:lankago/features/auth/presentation/pages/login_page.dart';
import 'package:lankago/features/home/presentation/pages/home_page.dart';
import 'package:lankago/shared/layouts/main_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(name: '/', path: '/', builder: (context, state) => LoginPage()),
    GoRoute(
      name: '/home',
      path: '/home',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      name: '/alerts',
      path: '/alerts',
      builder: (context, state) => const AlertPage(),
    ),
    GoRoute(
      name: '/experiences',
      path: '/experiences',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      name: '/trips',
      path: '/trips',
      builder: (context, state) => const MainScreen(),
    ),
  ],
);

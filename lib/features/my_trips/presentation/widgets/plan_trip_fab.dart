import 'package:flutter/material.dart';

class PlanTripFab extends StatelessWidget {
  final VoidCallback onPressed;

  const PlanTripFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}

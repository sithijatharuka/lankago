import 'package:flutter/material.dart';
import 'package:lankago/features/alert/presentation/widgets/alert_card.dart';

class LiveAlertsTab extends StatelessWidget {
  const LiveAlertsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 16),
        const Text(
          'Recent Alerts',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const AlertCard(),
      ],
    );
  }
}

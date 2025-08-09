import 'package:flutter/material.dart';

class ExperiencesTab extends StatelessWidget {
  const ExperiencesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.explore_outlined, size: 80, color: Colors.green),
          SizedBox(height: 20),
          Text(
            'Experiences Coming Soon',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Discover amazing travel experiences\nshared by fellow travelers',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          Text('Stay tuned!', style: TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
}

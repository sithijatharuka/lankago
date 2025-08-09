import 'package:flutter/material.dart';

class TripSummaryCard extends StatelessWidget {
  final String district;
  final int tripDays;

  const TripSummaryCard({
    super.key,
    required this.district,
    required this.tripDays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF3B82F6).withOpacity(0.1),
            const Color(0xFF1D4ED8).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Trip Summary',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E40AF),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$tripDays day${tripDays > 1 ? 's' : ''} adventure in $district district',
                  style: const TextStyle(
                    color: Color(0xFF1E40AF),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

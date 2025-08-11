import 'package:flutter/material.dart';
import 'package:lankago/core/widgets/app_bar.dart';

class TripDetailsPage extends StatelessWidget {
  final String tripName;
  final String destination;
  final String dates;
  final int peopleCount;

  const TripDetailsPage({
    super.key,
    required this.tripName,
    required this.destination,
    required this.dates,
    required this.peopleCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: appBar('Trip Details'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Trip Overview Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tripName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFF667EEA)),
                    const SizedBox(width: 6),
                    Text(
                      destination,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF374151),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.date_range, color: Color(0xFF10B981)),
                    const SizedBox(width: 6),
                    Text(
                      dates,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF374151),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.group, color: Color(0xFF8B5CF6)),
                    const SizedBox(width: 6),
                    Text(
                      '$peopleCount people',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF374151),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Notes or Description Section
          const Text(
            'Notes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Text(
              'Packing list, hotel bookings, activities, and reminders can be written here. You can expand this section to show more trip-related info.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

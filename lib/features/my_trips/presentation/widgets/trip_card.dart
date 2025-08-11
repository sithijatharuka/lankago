import 'package:flutter/material.dart';
import 'package:lankago/features/tripDetailsPage/presentation/pages/trip_details_page.dart';

class TripCard extends StatelessWidget {
  final String tripName;
  final String district;
  final DateTime startDate;
  final DateTime endDate;

  const TripCard({
    super.key,
    required this.tripName,
    required this.district,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    final dates = "${_formatDate(startDate)} - ${_formatDate(endDate)}";
    final duration = endDate.difference(startDate).inDays + 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => TripDetailsPage(
                    tripName: tripName,
                    destination: district,
                    dates: dates,
                    peopleCount: 1,
                  ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trip name and duration
              Row(
                children: [
                  Expanded(
                    child: Text(
                      tripName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Text(
                      '${duration}D',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Location
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    district,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Dates
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    dates,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // View details
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'View Details →',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
}

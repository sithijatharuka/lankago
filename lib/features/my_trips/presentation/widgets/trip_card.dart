import 'package:flutter/material.dart';
import 'package:lankago/features/tripDetailsPage/presentation/pages/trip_details_page.dart';

enum TripStatus { upcoming, completed, canceled }

class TripCard extends StatelessWidget {
  final String destination;
  final String tripName;
  final String dates;
  final int peopleCount;
  final TripStatus status;

  const TripCard({
    super.key,
    required this.destination,
    required this.tripName,
    required this.dates,
    required this.peopleCount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with destination and status
          buildHeaderRow(),
          const SizedBox(height: 8),
          // Trip name
          buildTripName(),
          const SizedBox(height: 8),
          // Dates
          buildDate(),
          const SizedBox(height: 16),
          // Bottom row with people count and view details
          buildBottomRow(context),
        ],
      ),
    );
  }

  Row buildBottomRow(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.people, color: Colors.grey[500], size: 20),
            const SizedBox(width: 8),
            Text(
              '$peopleCount People',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => const TripDetailsPage(
                      tripName: 'Family Adventure 2025',
                      destination: 'Ella, Sri Lanka',
                      dates: 'July 5 - July 10, 2025',
                      peopleCount: 3,
                    ),
              ),
            );
          },
          child: Row(
            children: [
              Text(
                'View Details',
                style: TextStyle(
                  color: Colors.blue[500],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios, color: Colors.blue[500], size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Text buildDate() =>
      Text(dates, style: TextStyle(fontSize: 16, color: Colors.grey[600]));

  Text buildTripName() {
    return Text(
      tripName,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Row buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          destination,
          style: TextStyle(
            color: Colors.orange[600],
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _getStatusColor(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _getStatusText(),
            style: TextStyle(
              color: _getStatusTextColor(),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case TripStatus.upcoming:
        return Colors.green[100]!;
      case TripStatus.completed:
        return Colors.grey[200]!;
      case TripStatus.canceled:
        return Colors.red[100]!;
    }
  }

  Color _getStatusTextColor() {
    switch (status) {
      case TripStatus.upcoming:
        return Colors.green[700]!;
      case TripStatus.completed:
        return Colors.grey[700]!;
      case TripStatus.canceled:
        return Colors.red[700]!;
    }
  }

  String _getStatusText() {
    switch (status) {
      case TripStatus.upcoming:
        return 'upcoming';
      case TripStatus.completed:
        return 'completed';
      case TripStatus.canceled:
        return 'canceled';
    }
  }
}

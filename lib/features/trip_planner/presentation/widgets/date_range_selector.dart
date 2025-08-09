import 'package:flutter/material.dart';

class DateRangeSelector extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final int tripDays;
  final VoidCallback onTap;

  const DateRangeSelector({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.tripDays,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFF9FAFB),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: const Color(0xFF2563EB),
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                startDate != null && endDate != null
                    ? "${startDate!.day}/${startDate!.month}/${startDate!.year} → ${endDate!.day}/${endDate!.month}/${endDate!.year}"
                    : "Select your travel dates",
                style: TextStyle(
                  color:
                      startDate != null
                          ? const Color(0xFF1F2937)
                          : const Color(0xFF6B7280),
                  fontSize: 16,
                ),
              ),
            ),
            if (tripDays > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$tripDays day${tripDays > 1 ? 's' : ''}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

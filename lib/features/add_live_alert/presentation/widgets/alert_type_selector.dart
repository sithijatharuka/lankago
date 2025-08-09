import 'package:flutter/material.dart';
import 'package:lankago/features/add_live_alert/presentation/pages/live_alert_page.dart';

class AlertTypeSelector extends StatelessWidget {
  final List<AlertType> alertTypes;
  final String? selectedType;
  final void Function(String) onSelected;

  const AlertTypeSelector({
    super.key,
    required this.alertTypes,
    required this.selectedType,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What\'s happening?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: alertTypes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3,
          ),
          itemBuilder: (context, index) {
            final alert = alertTypes[index];
            final isSelected = selectedType == alert.name;
            return GestureDetector(
              onTap: () => onSelected(alert.name),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      isSelected ? alert.color.withOpacity(0.2) : Colors.white,
                  border: Border.all(
                    color: isSelected ? alert.color : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(alert.icon, color: alert.color, size: 20),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        alert.name,
                        style: TextStyle(
                          color: alert.color,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

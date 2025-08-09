import 'package:flutter/material.dart';

class DistrictSelector extends StatelessWidget {
  final String? selectedDistrict;
  final List<String> districts;
  final ValueChanged<String?> onChanged;

  const DistrictSelector({
    super.key,
    required this.selectedDistrict,
    required this.districts,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF9FAFB),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedDistrict,
          hint: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: const Color(0xFF2563EB),
                size: 20,
              ),
              const SizedBox(width: 12),
              const Text(
                'Choose a district in Sri Lanka',
                style: TextStyle(color: Color(0xFF6B7280), fontSize: 16),
              ),
            ],
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: Color(0xFF6B7280)),
          items: districts.map((String district) {
            return DropdownMenuItem<String>(
              value: district,
              child: Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Text(
                  district,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

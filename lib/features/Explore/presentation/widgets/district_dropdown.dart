import 'package:flutter/material.dart';
import 'package:lankago/features/explore/data/local.dart';

class DistrictDropdown extends StatefulWidget {
  final ValueChanged<String?> onChanged; // ✅ callback
  final String? value; // ✅ so parent can control the selected value

  const DistrictDropdown({super.key, required this.onChanged, this.value});

  @override
  State<DistrictDropdown> createState() => _DistrictDropdownState();
}

class _DistrictDropdownState extends State<DistrictDropdown> {
  List<String> get districts => districtData.keys.toList()..sort();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.value, // ✅ controlled by parent
          hint: const Text(
            'Select a District',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF667EEA)),
          items:
              districts.map((String district) {
                return DropdownMenuItem<String>(
                  value: district,
                  child: Text(
                    district,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                );
              }).toList(),
          onChanged: (String? newValue) {
            widget.onChanged(newValue); // ✅ notify parent
          },
        ),
      ),
    );
  }
}

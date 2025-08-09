import 'package:flutter/material.dart';
import 'package:lankago/features/explore/data/local.dart';
import 'category_list.dart';

class DistrictContent extends StatelessWidget {
  final String selectedDistrict;

  const DistrictContent({super.key, required this.selectedDistrict});

  @override
  Widget build(BuildContext context) {
    final districtInfo = districtData[selectedDistrict];

    if (districtInfo == null) {
      return const Center(child: Text("No data available."));
    }

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        if (districtInfo['top_picks'] != null)
          CategoryList(title: "Top Picks", items: districtInfo['top_picks']),
        if (districtInfo['cultural'] != null)
          CategoryList(title: "Cultural", items: districtInfo['cultural']),
        if (districtInfo['hidden_gems'] != null)
          CategoryList(
            title: "Hidden Gems",
            items: districtInfo['hidden_gems'],
          ),
      ],
    );
  }
}

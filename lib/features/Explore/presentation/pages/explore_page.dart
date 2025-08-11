import 'package:flutter/material.dart';
import 'package:lankago/core/widgets/app_bar.dart';
import 'package:lankago/features/explore/presentation/widgets/district_dropdown.dart';
import 'package:lankago/features/explore/presentation/widgets/welcome_screen.dart';
import 'package:lankago/features/explore/presentation/widgets/district_content.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String? selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Explore Sri Lanka"),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          DistrictDropdown(
            onChanged: (value) {
              setState(() {
                selectedDistrict = value;
              });
            },
          ),
          Expanded(
            child:
                selectedDistrict == null
                    ? const WelcomeScreen()
                    : DistrictContent(selectedDistrict: selectedDistrict!),
          ),
        ],
      ),
    );
  }
}

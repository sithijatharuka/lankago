import 'package:flutter/material.dart';
import 'package:lankago/features/TripPlanner/presentation/widgets/budget_es_card.dart';
import 'package:lankago/features/TripPlanner/presentation/widgets/daily_planner_card.dart';
import 'package:lankago/features/TripPlanner/presentation/widgets/gen_ai_button.dart';
import 'package:lankago/features/TripPlanner/presentation/widgets/packing_list.dart';
import 'package:lankago/features/TripPlanner/presentation/widgets/save_button.dart';
import 'package:lankago/features/TripPlanner/presentation/widgets/share_button.dart';
import 'package:lankago/features/TripPlanner/presentation/widgets/text_feild.dart';
import 'package:lankago/features/home/presentation/widgets/heading_text.dart';
import 'package:lankago/features/home/presentation/widgets/search_bar.dart';
import 'package:lankago/core/widgets/app_bar.dart';

class TripPlanner extends StatefulWidget {
  const TripPlanner({super.key});

  @override
  State<TripPlanner> createState() => _TripPlannerState();
}

class _TripPlannerState extends State<TripPlanner> {
  final TextEditingController _tripNameController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Plan Your Trip'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customize and organize your travel experience',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
              Text(
                'Trip Name',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              buildTextField(
                hint: 'Search',
                controller: _tripNameController,
                icon: Icons.search,
              ),
              Text(
                'Date Range',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              buildTextField(
                hint: 'Date Range',
                controller: _destinationController,
                icon: Icons.search,
              ),
              Text(
                'Destination',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              buildTextField(
                hint: 'Date Range',
                controller: _destinationController,
                icon: Icons.search,
              ),
              buildGenAiButton(),
              headingText('Daily Planner'),

              buildDailyPlanner(),

              headingText('Budget Estimator'),
              buildBudgetCard(),

              headingText('Packing List'),
              buildPackingList(context),
              buildSaveButton(),
              buildShareButton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tripNameController.dispose();
    _destinationController.dispose();
    super.dispose();
  }
}

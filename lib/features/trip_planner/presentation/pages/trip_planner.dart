// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lankago/ask.dart';
// import 'package:lankago/features/home/presentation/widgets/button.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/budget_es_card.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/daily_planner_card.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/gen_ai_button.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/packing_list.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/save_button.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/share_button.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/text_feild.dart';
// import 'package:lankago/features/home/presentation/widgets/heading_text.dart';
// import 'package:lankago/features/home/presentation/widgets/search_bar.dart';
// import 'package:lankago/core/widgets/app_bar.dart';

// class TripPlanner extends StatefulWidget {
//   const TripPlanner({super.key});

//   @override
//   State<TripPlanner> createState() => _TripPlannerState();
// }

// class _TripPlannerState extends State<TripPlanner> {
//   final TextEditingController _tripNameController = TextEditingController();
//   final TextEditingController _destinationController = TextEditingController();
//   // DateTime? startDate;
//   DateTime? noOfDays;

//   String response = "";
//   bool loading = false;
//   void generatePlan() async {
//     setState(() {
//       loading = true;
//       response = "Planning your trip...";
//     });

//     final prompt = '''
// Create a detailed travel plan for ${_destinationController.text} for ${noOfDays}.
// days
// Return a JSON object with:

// {
//   "itinerary": {
//     "Day 1": {
//       "morning": "Visit XYZ",
//       "afternoon": "Lunch and relax",
//       "evening": "Beach walk"
//     },
//     ...
//   },
//   "budget_lkr": {
//     "Accommodation": 0,
//     "Transport": 0,
//     "Food & Drinks": 0,
//     "Activities": 0
//   },
//   "packing_list": ["Item 1", "Item 2"]
// }
// Only return JSON. Do not explain.
// ''';

//     try {
//       final result = await askGemini(prompt);
//       final cleaned =
//           result.replaceAll('```json', '').replaceAll('```', '').trim();
//       final decoded = jsonDecode(cleaned);

//       setState(() {
//         response = jsonEncode(decoded, toEncodable: (e) => e.toString());
//         loading = false;
//       });
//     } catch (e) {
//       setState(() {
//         response = "Error: $e";
//         loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar('Plan Your Trip'),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             spacing: 15,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Customize and organize your travel experience',
//                 style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
//               ),
//               Text(
//                 'Trip Name',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
//               ),
//               CustomTextField(
//                 hint: 'Name your trip',
//                 controller: _tripNameController,
//                 icon: Icons.route_rounded,
//               ),
//               Text(
//                 'Date Range',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
//               ),
//               CustomTextField(
//                 hint: 'Date Range',
//                 controller: _destinationController,
//                 icon: Icons.date_range_rounded,
//               ),
//               Text(
//                 'Destination',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
//               ),
//               CustomTextField(
//                 hint: 'Date Range',
//                 controller: _destinationController,
//                 icon: Icons.location_on,
//               ),
//               CustomButton(
//                 label: 'Generate',
//                 onPressed: () {
//                   generatePlan();
//                   print(response);
//                 },
//               ),
//               HeadingText(text: 'Daily Planner'),

//               DailyPlanner(),

//               HeadingText(text: 'Budget Estimator'),
//               BudgetCard(),

//               HeadingText(text: 'Packing List'),
//               PackingList(),
//               SaveButton(),
//               ShareButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _tripNameController.dispose();
//     _destinationController.dispose();
//     super.dispose();
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lankago/ask.dart';
import 'package:lankago/features/home/presentation/widgets/button.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/budget_es_card.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/daily_planner_card.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/packing_list.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/save_button.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/share_button.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/text_feild.dart';
import 'package:lankago/features/home/presentation/widgets/heading_text.dart';
import 'package:lankago/core/widgets/app_bar.dart';

class TripPlanner extends StatefulWidget {
  const TripPlanner({super.key});

  @override
  State<TripPlanner> createState() => _TripPlannerState();
}

class _TripPlannerState extends State<TripPlanner> {
  final TextEditingController _tripNameController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  String response = "";
  bool loading = false;

  int get tripDays {
    if (startDate == null || endDate == null) return 0;
    return endDate!.difference(startDate!).inDays + 1;
  }

  Future<void> pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  void generatePlan() async {
    // if (_destinationController.text.isEmpty || tripDays <= 0) {
    //   setState(() {
    //     response = "Please enter a valid destination and date range.";
    //   });
    //   return;
    // }

    setState(() {
      loading = true;
      response = "Planning your trip...";
    });

    final prompt = '''
Create a detailed and affordable travel plan from trincomalee to colombo for 3 days. Focus on budget-friendly recommendations for accommodation, transport, food, and activities that suit a traveler trying to save money.

Return a JSON object in the following format:

{
  "itinerary": {
    "Day 1": {
      "Morning": "Visit XYZ",
      "Afternoon": "Lunch and relax",
      "Evening": "Beach walk"
    },
    ...
  },
  "budget_lkr": {
    "Accommodation": 0,
    "Transport": 0,
    "Food & Drinks": 0,
    "Activities": 0
  },
  "packing_list": ["Item 1", "Item 2"]
}

Only return JSON. Do not explain.
''';

    try {
      final result = await askGemini(prompt);
      final cleaned =
          result.replaceAll('```json', '').replaceAll('```', '').trim();
      final decoded = jsonDecode(cleaned);

      // final decoded = jsonDecode(response);

      setState(() {
        response = jsonEncode(decoded, toEncodable: (e) => e.toString());
        loading = false;
      });
    } catch (e) {
      setState(() {
        response = "Error: $e";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Plan Your Trip'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customize and organize your travel experience',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),

            Text('Trip Name'),
            CustomTextField(
              hint: 'Name your trip',
              controller: _tripNameController,
              icon: Icons.route_rounded,
            ),

            Text('Date Range'),
            ElevatedButton.icon(
              onPressed: pickDateRange,
              icon: Icon(Icons.date_range_rounded),
              label: Text(
                startDate != null && endDate != null
                    ? "${startDate!.toLocal()} → ${endDate!.toLocal()}"
                    : "Pick date range",
              ),
            ),

            Text('Destination'),
            CustomTextField(
              hint: 'Enter destination',
              controller: _destinationController,
              icon: Icons.location_on,
            ),

            CustomButton(label: 'Generate', onPressed: generatePlan),

            if (loading) Center(child: CircularProgressIndicator()),
            if (response.isNotEmpty && !loading) ...[
              HeadingText(text: 'Daily Planner'),
              DailyPlanner(itinerary: _safeDecode(response, 'itinerary')),
              HeadingText(text: 'Budget Estimator'),
              BudgetCard(budget: _safeDecode(response, 'budget_lkr')),
              HeadingText(text: 'Packing List'),
              PackingList(
                packingItems: List<String>.from(
                  jsonDecode(response)['packing_list'],
                ),
              ),
              SaveButton(),
              ShareButton(),
            ],
          ],
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

dynamic _safeDecode(String jsonString, String key) {
  try {
    final decoded = jsonDecode(jsonString);
    return decoded[key];
  } catch (e) {
    print("JSON decode error for key '$key': $e");
    return null;
  }
}

// // import 'dart:convert';

// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:lankago/ask.dart';
// // import 'package:lankago/features/home/presentation/widgets/button.dart';
// // import 'package:lankago/features/trip_planner/presentation/widgets/budget_es_card.dart';
// // import 'package:lankago/features/trip_planner/presentation/widgets/daily_planner_card.dart';
// // import 'package:lankago/features/trip_planner/presentation/widgets/gen_ai_button.dart';
// // import 'package:lankago/features/trip_planner/presentation/widgets/packing_list.dart';
// // import 'package:lankago/features/trip_planner/presentation/widgets/save_button.dart';
// // import 'package:lankago/features/trip_planner/presentation/widgets/share_button.dart';
// // import 'package:lankago/features/trip_planner/presentation/widgets/text_feild.dart';
// // import 'package:lankago/features/home/presentation/widgets/heading_text.dart';
// // import 'package:lankago/features/home/presentation/widgets/search_bar.dart';
// // import 'package:lankago/core/widgets/app_bar.dart';

// // class TripPlanner extends StatefulWidget {
// //   const TripPlanner({super.key});

// //   @override
// //   State<TripPlanner> createState() => _TripPlannerState();
// // }

// // class _TripPlannerState extends State<TripPlanner> {
// //   final TextEditingController _tripNameController = TextEditingController();
// //   final TextEditingController _destinationController = TextEditingController();
// //   // DateTime? startDate;
// //   DateTime? noOfDays;

// //   String response = "";
// //   bool loading = false;
// //   void generatePlan() async {
// //     setState(() {
// //       loading = true;
// //       response = "Planning your trip...";
// //     });

// //     final prompt = '''
// // Create a detailed travel plan for ${_destinationController.text} for ${noOfDays}.
// // days
// // Return a JSON object with:

// // {
// //   "itinerary": {
// //     "Day 1": {
// //       "morning": "Visit XYZ",
// //       "afternoon": "Lunch and relax",
// //       "evening": "Beach walk"
// //     },
// //     ...
// //   },
// //   "budget_lkr": {
// //     "Accommodation": 0,
// //     "Transport": 0,
// //     "Food & Drinks": 0,
// //     "Activities": 0
// //   },
// //   "packing_list": ["Item 1", "Item 2"]
// // }
// // Only return JSON. Do not explain.
// // ''';

// //     try {
// //       final result = await askGemini(prompt);
// //       final cleaned =
// //           result.replaceAll('```json', '').replaceAll('```', '').trim();
// //       final decoded = jsonDecode(cleaned);

// //       setState(() {
// //         response = jsonEncode(decoded, toEncodable: (e) => e.toString());
// //         loading = false;
// //       });
// //     } catch (e) {
// //       setState(() {
// //         response = "Error: $e";
// //         loading = false;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: appBar('Plan Your Trip'),
// //       backgroundColor: Colors.white,
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.all(20.0),
// //           child: Column(
// //             spacing: 15,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 'Customize and organize your travel experience',
// //                 style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
// //               ),
// //               Text(
// //                 'Trip Name',
// //                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
// //               ),
// //               CustomTextField(
// //                 hint: 'Name your trip',
// //                 controller: _tripNameController,
// //                 icon: Icons.route_rounded,
// //               ),
// //               Text(
// //                 'Date Range',
// //                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
// //               ),
// //               CustomTextField(
// //                 hint: 'Date Range',
// //                 controller: _destinationController,
// //                 icon: Icons.date_range_rounded,
// //               ),
// //               Text(
// //                 'Destination',
// //                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
// //               ),
// //               CustomTextField(
// //                 hint: 'Date Range',
// //                 controller: _destinationController,
// //                 icon: Icons.location_on,
// //               ),
// //               CustomButton(
// //                 label: 'Generate',
// //                 onPressed: () {
// //                   generatePlan();
// //                   print(response);
// //                 },
// //               ),
// //               HeadingText(text: 'Daily Planner'),

// //               DailyPlanner(),

// //               HeadingText(text: 'Budget Estimator'),
// //               BudgetCard(),

// //               HeadingText(text: 'Packing List'),
// //               PackingList(),
// //               SaveButton(),
// //               ShareButton(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _tripNameController.dispose();
// //     _destinationController.dispose();
// //     super.dispose();
// //   }
// // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:lankago/ask.dart';
// import 'package:lankago/features/home/presentation/widgets/button.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/budget_es_card.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/daily_planner_card.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/packing_list.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/save_button.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/share_button.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/text_feild.dart';
// import 'package:lankago/features/home/presentation/widgets/heading_text.dart';
// import 'package:lankago/core/widgets/app_bar.dart';

// class TripPlanner extends StatefulWidget {
//   const TripPlanner({super.key});

//   @override
//   State<TripPlanner> createState() => _TripPlannerState();
// }

// class _TripPlannerState extends State<TripPlanner> {
//   final TextEditingController _tripNameController = TextEditingController();
//   final TextEditingController _destinationController = TextEditingController();
//   DateTime? startDate;
//   DateTime? endDate;

//   String response = "";
//   bool loading = false;

//   int get tripDays {
//     if (startDate == null || endDate == null) return 0;
//     return endDate!.difference(startDate!).inDays + 1;
//   }

//   Future<void> pickDateRange() async {
//     final picked = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );

//     if (picked != null) {
//       setState(() {
//         startDate = picked.start;
//         endDate = picked.end;
//       });
//     }
//   }

//   void generatePlan() async {
//     // if (_destinationController.text.isEmpty || tripDays <= 0) {
//     //   setState(() {
//     //     response = "Please enter a valid destination and date range.";
//     //   });
//     //   return;
//     // }

//     setState(() {
//       loading = true;
//       response = "Planning your trip...";
//     });

//     final prompt = '''
// Create a detailed and affordable travel plan from trincomalee to colombo for 3 days. Focus on budget-friendly recommendations for accommodation, transport, food, and activities that suit a traveler trying to save money.

// Return a JSON object in the following format:

// {
//   "itinerary": {
//     "Day 1": {
//       "Morning": "Visit XYZ",
//       "Afternoon": "Lunch and relax",
//       "Evening": "Beach walk"
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

//       // final decoded = jsonDecode(response);

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
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           spacing: 10,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Customize and organize your travel experience',
//               style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
//             ),

//             Text('Trip Name'),
//             CustomTextField(
//               hint: 'Name your trip',
//               controller: _tripNameController,
//               icon: Icons.route_rounded,
//             ),

//             Text('Date Range'),
//             ElevatedButton.icon(
//               onPressed: pickDateRange,
//               icon: Icon(Icons.date_range_rounded),
//               label: Text(
//                 startDate != null && endDate != null
//                     ? "${startDate!.toLocal()} → ${endDate!.toLocal()}"
//                     : "Pick date range",
//               ),
//             ),

//             Text('Destination'),
//             CustomTextField(
//               hint: 'Enter destination',
//               controller: _destinationController,
//               icon: Icons.location_on,
//             ),

//             CustomButton(label: 'Generate', onPressed: generatePlan),

//             if (loading) Center(child: CircularProgressIndicator()),
//             if (response.isNotEmpty && !loading) ...[
//               HeadingText(text: 'Daily Planner'),
//               DailyPlanner(itinerary: _safeDecode(response, 'itinerary')),
//               HeadingText(text: 'Budget Estimator'),
//               BudgetCard(budget: _safeDecode(response, 'budget_lkr')),
//               HeadingText(text: 'Packing List'),
//               PackingList(
//                 packingItems: List<String>.from(
//                   jsonDecode(response)['packing_list'],
//                 ),
//               ),
//               SaveButton(),
//               ShareButton(),
//             ],
//           ],
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

// dynamic _safeDecode(String jsonString, String key) {
//   try {
//     final decoded = jsonDecode(jsonString);
//     return decoded[key];
//   } catch (e) {
//     print("JSON decode error for key '$key': $e");
//     return null;
//   }
// }

/// mmmrererer

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:lankago/ask.dart';
// import 'package:lankago/features/home/presentation/widgets/button.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/budget_es_card.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/daily_planner_card.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/packing_list.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/save_button.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/share_button.dart';
// import 'package:lankago/features/trip_planner/presentation/widgets/text_feild.dart';
// import 'package:lankago/features/home/presentation/widgets/heading_text.dart';
// import 'package:lankago/core/widgets/app_bar.dart';

// class TripPlanner extends StatefulWidget {
//   const TripPlanner({super.key});

//   @override
//   State<TripPlanner> createState() => _TripPlannerState();
// }

// class _TripPlannerState extends State<TripPlanner> {
//   final TextEditingController _tripNameController = TextEditingController();
//   DateTime? startDate;
//   DateTime? endDate;

//   String response = "";
//   bool loading = false;
//   String? selectedDistrict;

//   // Sri Lankan districts
//   final List<String> sriLankanDistricts = [
//     'Ampara',
//     'Anuradhapura',
//     'Badulla',
//     'Batticaloa',
//     'Colombo',
//     'Galle',
//     'Gampaha',
//     'Hambantota',
//     'Jaffna',
//     'Kalutara',
//     'Kandy',
//     'Kegalle',
//     'Kilinochchi',
//     'Kurunegala',
//     'Mannar',
//     'Matale',
//     'Matara',
//     'Monaragala',
//     'Mullaitivu',
//     'Nuwara Eliya',
//     'Polonnaruwa',
//     'Puttalam',
//     'Ratnapura',
//     'Trincomalee',
//     'Vavuniya',
//   ];

//   int get tripDays {
//     if (startDate == null || endDate == null) return 0;
//     return endDate!.difference(startDate!).inDays + 1;
//   }

//   Future<void> pickDateRange() async {
//     final picked = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );

//     if (picked != null) {
//       setState(() {
//         startDate = picked.start;
//         endDate = picked.end;
//       });
//     }
//   }

//   void generatePlan() async {
//     if (selectedDistrict == null || tripDays <= 0) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Please select a district and valid date range."),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     setState(() {
//       loading = true;
//       response = "Planning your trip...";
//     });

//     final prompt = '''
// Create a detailed and affordable travel plan for ${selectedDistrict} district in Sri Lanka for ${tripDays} days. Focus on budget-friendly recommendations for accommodation, transport, food, and activities that suit a traveler trying to save money.

// Include specific places to visit in ${selectedDistrict} district, local food recommendations, cultural sites, natural attractions, and practical travel tips.

// Return a JSON object in the following format:

// {
//   "itinerary": {
//     "Day 1": {
//       "Morning": "Visit specific attraction in ${selectedDistrict}",
//       "Afternoon": "Local lunch and activity",
//       "Evening": "Evening activity or relaxation"
//     },
//     "Day 2": {
//       "Morning": "Morning activity",
//       "Afternoon": "Afternoon exploration",
//       "Evening": "Evening experience"
//     }
//     // ... continue for ${tripDays} days
//   },
//   "budget_lkr": {
//     "Accommodation": 0,
//     "Transport": 0,
//     "Food & Drinks": 0,
//     "Activities": 0
//   },
//   "packing_list": ["Item 1", "Item 2", "Item 3"]
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
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           spacing: 15,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Customize and organize your travel experience in Sri Lanka',
//               style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
//             ),

//             // Trip Name Section
//             Text(
//               'Trip Name',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//             ),
//             CustomTextField(
//               hint: 'Name your trip',
//               controller: _tripNameController,
//               icon: Icons.route_rounded,
//             ),

//             // Date Range Section
//             Text(
//               'Date Range',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//             ),
//             Container(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: pickDateRange,
//                 icon: Icon(Icons.date_range_rounded, color: Colors.blue),
//                 label: Text(
//                   startDate != null && endDate != null
//                       ? "${startDate!.day}/${startDate!.month}/${startDate!.year} → ${endDate!.day}/${endDate!.month}/${endDate!.year} (${tripDays} days)"
//                       : "Select your travel dates",
//                   style: TextStyle(color: Colors.black87),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.grey[100],
//                   elevation: 0,
//                   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
//                   alignment: Alignment.centerLeft,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     side: BorderSide(color: Colors.grey[300]!),
//                   ),
//                 ),
//               ),
//             ),

//             // District Selection Section
//             Text(
//               'Destination (Sri Lankan District)',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//             ),
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey[300]!),
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.grey[50],
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   value: selectedDistrict,
//                   hint: Row(
//                     children: [
//                       Icon(Icons.location_on, color: Colors.blue, size: 20),
//                       SizedBox(width: 12),
//                       Text(
//                         'Select a district in Sri Lanka',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                   isExpanded: true,
//                   items:
//                       sriLankanDistricts.map((String district) {
//                         return DropdownMenuItem<String>(
//                           value: district,
//                           child: Padding(
//                             padding: EdgeInsets.only(left: 32),
//                             child: Text(
//                               district,
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedDistrict = newValue;
//                     });
//                   },
//                 ),
//               ),
//             ),

//             // Show selected info
//             if (selectedDistrict != null && tripDays > 0)
//               Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.blue[50],
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.blue[200]!),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.info_outline, color: Colors.blue, size: 20),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         'Planning ${tripDays} day${tripDays > 1 ? 's' : ''} trip to ${selectedDistrict} district',
//                         style: TextStyle(color: Colors.blue[800], fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//             // Generate Button
//             CustomButton(
//               label: loading ? 'Generating...' : 'Generate Trip Plan',
//               onPressed: loading ? () {} : generatePlan,
//             ),

//             // Loading Indicator
//             if (loading)
//               Center(
//                 child: Column(
//                   children: [
//                     CircularProgressIndicator(),
//                     SizedBox(height: 8),
//                     Text(
//                       'Creating your personalized trip plan...',
//                       style: TextStyle(color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),

//             // Results Section
//             if (response.isNotEmpty &&
//                 !loading &&
//                 !response.startsWith("Error")) ...[
//               Divider(height: 30, thickness: 1),

//               HeadingText(text: 'Daily Planner'),
//               DailyPlanner(itinerary: _safeDecode(response, 'itinerary')),

//               HeadingText(text: 'Budget Estimator'),
//               BudgetCard(budget: _safeDecode(response, 'budget_lkr')),

//               HeadingText(text: 'Packing List'),
//               PackingList(
//                 packingItems: _safeDecodeList(response, 'packing_list'),
//               ),

//               SaveButton(),
//               ShareButton(),
//             ],

//             // Error Display
//             if (response.startsWith("Error"))
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.red[50],
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.red[200]!),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.error_outline, color: Colors.red),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         response,
//                         style: TextStyle(color: Colors.red[800]),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _tripNameController.dispose();
//     super.dispose();
//   }
// }

// // Helper function to safely decode JSON data
// dynamic _safeDecode(String jsonString, String key) {
//   try {
//     final decoded = jsonDecode(jsonString);
//     return decoded[key];
//   } catch (e) {
//     print("JSON decode error for key '$key': $e");
//     return null;
//   }
// }

// // Helper function to safely decode list from JSON
// List<String> _safeDecodeList(String jsonString, String key) {
//   try {
//     final decoded = jsonDecode(jsonString);
//     final list = decoded[key];
//     if (list is List) {
//       return List<String>.from(list);
//     }
//     return [];
//   } catch (e) {
//     print("JSON decode error for list '$key': $e");
//     return [];
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

class _TripPlannerState extends State<TripPlanner>
    with TickerProviderStateMixin {
  final TextEditingController _tripNameController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  String response = "";
  bool loading = false;
  String? selectedDistrict;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Sri Lankan districts with better organization
  final List<String> sriLankanDistricts = [
    'Ampara',
    'Anuradhapura',
    'Badulla',
    'Batticaloa',
    'Colombo',
    'Galle',
    'Gampaha',
    'Hambantota',
    'Jaffna',
    'Kalutara',
    'Kandy',
    'Kegalle',
    'Kilinochchi',
    'Kurunegala',
    'Mannar',
    'Matale',
    'Matara',
    'Monaragala',
    'Mullaitivu',
    'Nuwara Eliya',
    'Polonnaruwa',
    'Puttalam',
    'Ratnapura',
    'Trincomalee',
    'Vavuniya',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  int get tripDays {
    if (startDate == null || endDate == null) return 0;
    return endDate!.difference(startDate!).inDays + 1;
  }

  Future<void> pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFF2563EB),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  void generatePlan() async {
    if (selectedDistrict == null || tripDays <= 0) {
      _showSnackBar(
        "Please select a district and valid date range.",
        isError: true,
      );
      return;
    }

    setState(() {
      loading = true;
      response = "";
    });

    _animationController.forward();

    final prompt = '''
Create a detailed and affordable travel plan for ${selectedDistrict} district in Sri Lanka for ${tripDays} days. Focus on budget-friendly recommendations for accommodation, transport, food, and activities that suit a traveler trying to save money.

Include specific places to visit in ${selectedDistrict} district, local food recommendations, cultural sites, natural attractions, and practical travel tips.

Return a JSON object in the following format:

{
  "itinerary": {
    "Day 1": {
      "Morning": "Visit specific attraction in ${selectedDistrict}",
      "Afternoon": "Local lunch and activity",
      "Evening": "Evening activity or relaxation"
    },
    "Day 2": {
      "Morning": "Morning activity",
      "Afternoon": "Afternoon exploration",
      "Evening": "Evening experience"
    }
    // ... continue for ${tripDays} days
  },
  "budget_lkr": {
    "Accommodation": 0,
    "Transport": 0,
    "Food & Drinks": 0,
    "Activities": 0
  },
  "packing_list": ["Item 1", "Item 2", "Item 3"]
}

Only return JSON. Do not explain.
''';

    try {
      final result = await askGemini(prompt);
      final cleaned =
          result.replaceAll('```json', '').replaceAll('```', '').trim();
      final decoded = jsonDecode(cleaned);

      setState(() {
        response = jsonEncode(decoded, toEncodable: (e) => e.toString());
        loading = false;
      });

      _showSnackBar("Trip plan generated successfully!", isError: false);
    } catch (e) {
      setState(() {
        response = "Error: $e";
        loading = false;
      });
      _showSnackBar(
        "Failed to generate trip plan. Please try again.",
        isError: true,
      );
    }

    _animationController.reverse();
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor:
            isError ? const Color(0xFFDC2626) : const Color(0xFF059669),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Plan Your Trip'),
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeaderSection(),
            const SizedBox(height: 24),

            // Form Section
            _buildFormCard(),
            const SizedBox(height: 20),

            // Trip Summary Card
            if (selectedDistrict != null && tripDays > 0) ...[
              _buildTripSummaryCard(),
              const SizedBox(height: 20),
            ],

            // Generate Button
            _buildGenerateButton(),
            const SizedBox(height: 20),

            // Loading Section
            if (loading) _buildLoadingSection(),

            // Results Section
            if (response.isNotEmpty &&
                !loading &&
                !response.startsWith("Error")) ...[
              const SizedBox(height: 24),
              _buildResultsSection(),
            ],

            // Error Display
            if (response.startsWith("Error")) _buildErrorSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🌴 Plan Your Sri Lankan Adventure',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Customize and organize your travel experience with AI-powered recommendations',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trip Name Section
          _buildSectionTitle('Trip Name', Icons.route_rounded),
          const SizedBox(height: 12),
          CustomTextField(
            hint: 'Give your trip a memorable name',
            controller: _tripNameController,
            icon: Icons.edit_outlined,
          ),
          const SizedBox(height: 24),

          // Date Range Section
          _buildSectionTitle('Travel Dates', Icons.date_range_rounded),
          const SizedBox(height: 12),
          _buildDateRangeSelector(),
          const SizedBox(height: 24),

          // District Selection Section
          _buildSectionTitle('Destination', Icons.location_on_outlined),
          const SizedBox(height: 12),
          _buildDistrictSelector(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF2563EB)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }

  Widget _buildDateRangeSelector() {
    return InkWell(
      onTap: pickDateRange,
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
                  '${tripDays} day${tripDays > 1 ? 's' : ''}',
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

  Widget _buildDistrictSelector() {
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
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF6B7280)),
          items:
              sriLankanDistricts.map((String district) {
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
          onChanged: (String? newValue) {
            setState(() {
              selectedDistrict = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildTripSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF3B82F6).withOpacity(0.1),
            const Color(0xFF1D4ED8).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Trip Summary',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E40AF),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${tripDays} day${tripDays > 1 ? 's' : ''} adventure in ${selectedDistrict} district',
                  style: const TextStyle(
                    color: Color(0xFF1E40AF),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateButton() {
    final bool canGenerate = selectedDistrict != null && tripDays > 0;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: loading || !canGenerate ? null : generatePlan,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFE5E7EB),
          disabledForegroundColor: const Color(0xFF9CA3AF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading) ...[
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const SizedBox(width: 12),
            ] else ...[
              const Icon(Icons.auto_awesome, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              loading ? 'Generating Your Plan...' : 'Generate AI Trip Plan',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
            ),
            const SizedBox(height: 16),
            const Text(
              'Creating your personalized trip plan...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This may take a few moments',
              style: TextStyle(fontSize: 14, color: const Color(0xFF6B7280)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeadingText(text: 'Your Trip Plan is Ready! 🎉'),
        const SizedBox(height: 16),

        HeadingText(text: 'Daily Itinerary'),
        const SizedBox(height: 8),
        DailyPlanner(itinerary: _safeDecode(response, 'itinerary')),
        const SizedBox(height: 24),

        HeadingText(text: 'Budget Breakdown'),
        const SizedBox(height: 8),
        BudgetCard(budget: _safeDecode(response, 'budget_lkr')),
        const SizedBox(height: 24),

        HeadingText(text: 'Packing Essentials'),
        const SizedBox(height: 8),
        PackingList(packingItems: _safeDecodeList(response, 'packing_list')),
        const SizedBox(height: 32),

        // Action Buttons
        Row(
          children: [
            Expanded(child: SaveButton()),
            const SizedBox(width: 12),
            Expanded(child: ShareButton()),
          ],
        ),
      ],
    );
  }

  Widget _buildErrorSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFDC2626), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Something went wrong',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFDC2626),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  response,
                  style: const TextStyle(color: Color(0xFFB91C1C)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tripNameController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}

// Helper function to safely decode JSON data
dynamic _safeDecode(String jsonString, String key) {
  try {
    final decoded = jsonDecode(jsonString);
    return decoded[key];
  } catch (e) {
    print("JSON decode error for key '$key': $e");
    return null;
  }
}

// Helper function to safely decode list from JSON
List<String> _safeDecodeList(String jsonString, String key) {
  try {
    final decoded = jsonDecode(jsonString);
    final list = decoded[key];
    if (list is List) {
      return List<String>.from(list);
    }
    return [];
  } catch (e) {
    print("JSON decode error for list '$key': $e");
    return [];
  }
}

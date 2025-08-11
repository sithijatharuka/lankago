import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lankago/ask.dart';
import 'package:lankago/core/services/trip_service.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/budget_es_card.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/daily_planner_card.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/date_range_selector.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/district_selector.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/generate_button.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/header_section.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/packing_list.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/save_button.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/section_title.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/share_button.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/text_feild.dart';
import 'package:lankago/features/home/presentation/widgets/heading_text.dart';
import 'package:lankago/core/widgets/app_bar.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/trip_summary_card.dart';

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

  final FirestoreService _firestoreService = FirestoreService();

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
Create a detailed and affordable travel plan for $selectedDistrict district in Sri Lanka for ${tripDays} days. Focus on budget-friendly recommendations for accommodation, transport, food, and activities that suit a traveler trying to save money.

Include specific places to visit in $selectedDistrict district, local food recommendations, cultural sites, natural attractions, and practical travel tips.

Return a JSON object in the following format:

{
  "itinerary": {
    "Day 1": {
      "Morning": "Visit specific attraction in $selectedDistrict",
      "Afternoon": "Local lunch and activity",
      "Evening": "Evening activity or relaxation"
    },
    "Day 2": {
      "Morning": "Morning activity",
      "Afternoon": "Afternoon exploration",
      "Evening": "Evening experience"
    }
    // ... continue for $tripDays days
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

      // Save to Firestore
      await _firestoreService.addTripPlan(
        tripName:
            _tripNameController.text.trim().isEmpty
                ? 'My Trip'
                : _tripNameController.text.trim(),
        district: selectedDistrict!,
        startDate: startDate!,
        endDate: endDate!,
        itinerary: decoded['itinerary'] ?? {},
        budget: decoded['budget_lkr'] ?? {},
        packingList: List<String>.from(decoded['packing_list'] ?? []),
      );

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
            HeaderSection(),
            const SizedBox(height: 24),
            _buildFormCard(),
            const SizedBox(height: 20),
            if (selectedDistrict != null && tripDays > 0) ...[
              TripSummaryCard(tripDays: tripDays, district: selectedDistrict!),
              const SizedBox(height: 20),
            ],
            GenerateButton(
              loading: loading,
              enabled: selectedDistrict != null && tripDays > 0,
              onPressed: generatePlan,
            ),
            const SizedBox(height: 20),
            if (loading) _buildLoadingSection(),
            if (response.isNotEmpty &&
                !loading &&
                !response.startsWith("Error")) ...[
              const SizedBox(height: 24),
              _buildResultsSection(),
            ],
            if (response.startsWith("Error")) _buildErrorSection(),
          ],
        ),
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
          SectionTitle(title: 'Trip Name', icon: Icons.route_rounded),
          const SizedBox(height: 12),
          CustomTextField(
            hint: 'Give your trip a memorable name',
            controller: _tripNameController,
            icon: Icons.edit_outlined,
          ),
          const SizedBox(height: 24),
          SectionTitle(title: 'Travel Dates', icon: Icons.date_range_rounded),
          const SizedBox(height: 12),
          DateRangeSelector(
            startDate: startDate,
            endDate: endDate,
            tripDays: tripDays,
            onTap: pickDateRange,
          ),
          const SizedBox(height: 24),
          SectionTitle(title: 'Destination', icon: Icons.location_on_outlined),
          const SizedBox(height: 12),
          DistrictSelector(
            districts: sriLankanDistricts,
            selectedDistrict: selectedDistrict,
            onChanged: (val) => setState(() => selectedDistrict = val),
          ),
        ],
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
        // Row(
        //   children: [
        //     Expanded(child: SaveButton()),
        //     const SizedBox(width: 12),
        //     Expanded(child: ShareButton()),
        //   ],
        // ),
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

// Helper functions to safely decode JSON data
dynamic _safeDecode(String jsonString, String key) {
  try {
    final decoded = jsonDecode(jsonString);
    return decoded[key];
  } catch (e) {
    print("JSON decode error for key '$key': $e");
    return null;
  }
}

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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lankago/core/services/ask.dart';
import 'package:lankago/core/widgets/app_bar.dart';
import '../widgets/details_section.dart';
import '../widgets/details_list_section.dart';

class PlaceScreen extends StatefulWidget {
  final Map<String, dynamic> place;
  final Color accentColor;

  const PlaceScreen({
    super.key,
    required this.place,
    required this.accentColor,
  });

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  bool loading = true;
  Map<String, dynamic>? placeDetails;

  @override
  void initState() {
    super.initState();
    fetchPlaceDetails();
  }

  void fetchPlaceDetails() async {
    setState(() => loading = true);

    final prompt = '''
Provide detailed information about "${widget.place['title']}" in Sri Lanka.
Return only JSON with fields: overview, highlights, best_time_to_visit, activities, local_tips, estimated_cost, duration, difficulty, category.
''';

    try {
      final result = await askGemini(prompt);
      final cleaned =
          result.replaceAll('```json', '').replaceAll('```', '').trim();
      final decoded = jsonDecode(cleaned);

      setState(() {
        placeDetails = decoded;
        loading = false;
      });
    } catch (e) {
      setState(() {
        placeDetails = {"error": "Failed to load place details"};
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget.place['title'] ?? ''),
      body:
          loading
              ? const Center(child: CircularProgressIndicator())
              : placeDetails == null || placeDetails!.containsKey('error')
              ? Center(
                child: Text(placeDetails?['error'] ?? "Failed to load details"),
              )
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailsSection(
                      title: "Overview",
                      content: placeDetails!['overview'] ?? '',
                    ),
                    DetailsListSection(
                      title: "Highlights",
                      items: placeDetails!['highlights'],
                    ),
                    DetailsListSection(
                      title: "Activities",
                      items: placeDetails!['activities'],
                    ),
                    DetailsListSection(
                      title: "Local Tips",
                      items: placeDetails!['local_tips'],
                    ),
                    DetailsSection(
                      title: "Best Time to Visit",
                      content: placeDetails!['best_time_to_visit'] ?? '',
                    ),
                  ],
                ),
              ),
    );
  }
}

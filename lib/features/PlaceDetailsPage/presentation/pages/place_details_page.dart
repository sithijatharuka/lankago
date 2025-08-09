import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lankago/ask.dart';
import '../widgets/details_header.dart';
import '../widgets/details_section.dart';
import '../widgets/details_list_section.dart';

class PlaceDetailsPage extends StatefulWidget {
  final Map<String, dynamic> place;
  final Color accentColor;

  const PlaceDetailsPage({
    super.key,
    required this.place,
    required this.accentColor,
  });

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
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
Provide detailed information about "${widget.place['title']}" in ${widget.place['location']}, Sri Lanka.
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
        placeDetails = {"error": "Failed to load place details: $e"};
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place['title'] ?? ''),
        backgroundColor: widget.accentColor,
      ),
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
                    DetailsHeader(place: widget.place, details: placeDetails!),
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

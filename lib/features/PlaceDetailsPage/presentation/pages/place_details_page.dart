import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lankago/ask.dart'; // Make sure this is your Gemini API helper

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
    setState(() {
      loading = true;
    });

    final prompt = '''
You're a travel expert. Provide detailed information about "${widget.place['title']}" in ${widget.place['location']}, Sri Lanka. 

Return only JSON in the following format:

{
  "overview": "Detailed description of the place (3-4 sentences)",
  "highlights": [
    "Key attraction or feature 1",
    "Key attraction or feature 2",
    "Key attraction or feature 3",
    "Key attraction or feature 4"
  ],
  "best_time_to_visit": "When is the best time to visit and why",
  "activities": [
    "Activity 1",
    "Activity 2",
    "Activity 3",
    "Activity 4"
  ],
  "local_tips": [
    "Practical tip 1",
    "Practical tip 2",
    "Practical tip 3"
  ],
  "estimated_cost": "Budget range in LKR or USD",
  "duration": "Recommended stay duration",
  "difficulty": "Easy/Moderate/Challenging",
  "category": "Nature/Cultural/Adventure/Historical/Beach"
}
Only return JSON. Do not explain.
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
      backgroundColor: const Color(0xFFF8FAFB),
      body: CustomScrollView(
        slivers: [
          // Hero App Bar
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: widget.accentColor,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.place['title'] ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.accentColor,
                      widget.accentColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Decorative elements
                    Positioned(
                      top: 50,
                      right: -30,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: -20,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child:
                loading
                    ? _buildLoadingState()
                    : placeDetails == null || placeDetails!.containsKey('error')
                    ? _buildErrorState()
                    : _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: 400,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(widget.accentColor),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Loading place details...',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
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
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.error_outline,
              color: Color(0xFFEF4444),
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            placeDetails?['error'] ?? "Failed to load details",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Color(0xFF374151)),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Basic Info Card
          _buildBasicInfoCard(),
          const SizedBox(height: 20),

          // Overview
          _buildSectionCard(
            icon: Icons.info_outline,
            title: 'Overview',
            content: Text(
              placeDetails!['overview'] ?? '',
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF4B5563),
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Highlights
          _buildSectionCard(
            icon: Icons.star_outline,
            title: 'Highlights',
            content: Column(
              children: List.generate(
                placeDetails!['highlights']?.length ?? 0,
                (index) => _buildListItem(placeDetails!['highlights'][index]),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Activities
          _buildSectionCard(
            icon: Icons.local_activity_outlined,
            title: 'Activities',
            content: Column(
              children: List.generate(
                placeDetails!['activities']?.length ?? 0,
                (index) => _buildListItem(placeDetails!['activities'][index]),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Local Tips
          _buildSectionCard(
            icon: Icons.tips_and_updates_outlined,
            title: 'Local Tips',
            content: Column(
              children: List.generate(
                placeDetails!['local_tips']?.length ?? 0,
                (index) => _buildTipItem(placeDetails!['local_tips'][index]),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Best Time to Visit
          _buildSectionCard(
            icon: Icons.calendar_today_outlined,
            title: 'Best Time to Visit',
            content: Text(
              placeDetails!['best_time_to_visit'] ?? '',
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF4B5563),
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildBasicInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: widget.accentColor, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.place['location'] ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoChip(
                icon: Icons.schedule,
                label: placeDetails!['duration'] ?? 'N/A',
              ),
              const SizedBox(width: 12),
              _buildInfoChip(
                icon: Icons.attach_money,
                label: placeDetails!['estimated_cost'] ?? 'N/A',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInfoChip(
                icon: Icons.trending_up,
                label: placeDetails!['difficulty'] ?? 'N/A',
              ),
              const SizedBox(width: 12),
              _buildInfoChip(
                icon: Icons.category,
                label: placeDetails!['category'] ?? 'N/A',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: widget.accentColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: widget.accentColor),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: widget.accentColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required Widget content,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 20, color: widget.accentColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 12),
            decoration: BoxDecoration(
              color: widget.accentColor,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF4B5563),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF3C7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFFCD34D), width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.lightbulb_outline,
              color: Color(0xFFD97706),
              size: 18,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF92400E),
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

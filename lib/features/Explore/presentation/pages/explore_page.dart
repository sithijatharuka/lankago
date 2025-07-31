import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lankago/ask.dart';
import 'package:lankago/features/PlaceDetailsPage/presentation/pages/place_details_page.dart'; // Make sure this is your Gemini API helper

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool loading = false;
  Map<String, dynamic>? exploreData;

  @override
  void initState() {
    super.initState();
    generateExploreContent();
  }

  void generateExploreContent() async {
    setState(() {
      loading = true;
    });

    final prompt = '''
You're a travel expert. Suggest top picks and hidden gems in Sri Lanka that are lesser known but worth visiting. Focus on unique, affordable, and authentic local experiences.

Return only JSON in the following format:

{
  "top_picks": [
    {
      "title": "Place Name",
      "description": "Short highlight about why it's great",
      "location": "District or area"
    }
  ],
  "hidden_gems": [
    {
      "title": "Place Name",
      "description": "Short highlight about what makes it special",
      "location": "District or area"
    }
  ]
}
Only return JSON. Do not explain.
''';

    try {
      final result = await askGemini(prompt);
      final cleaned =
          result.replaceAll('```json', '').replaceAll('```', '').trim();
      final decoded = jsonDecode(cleaned);

      setState(() {
        exploreData = decoded;
        loading = false;
      });
    } catch (e) {
      setState(() {
        exploreData = {"error": "Failed to load explore content: $e"};
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore Sri Lanka')),
      backgroundColor: const Color(0xFFF8FAFB),
      body:
          loading
              ? _buildLoadingState()
              : exploreData == null || exploreData!.containsKey('error')
              ? _buildErrorState()
              : _buildContent(),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
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
            child: const CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF667EEA)),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Discovering amazing places...',
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
            exploreData?['error'] ?? "Something went wrong",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Color(0xFF374151)),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Picks Section
          _buildSectionHeader(
            icon: '✨',
            title: 'Top Picks',
            subtitle: 'Must-visit destinations',
          ),
          const SizedBox(height: 16),
          ...List.generate(exploreData!['top_picks'].length, (index) {
            final place = exploreData!['top_picks'][index];
            return ExploreCard(place: place, isTopPick: true, index: index);
          }),

          const SizedBox(height: 40),

          // Hidden Gems Section
          _buildSectionHeader(
            icon: '💎',
            title: 'Hidden Gems',
            subtitle: 'Off the beaten path',
          ),
          const SizedBox(height: 16),
          ...List.generate(exploreData!['hidden_gems'].length, (index) {
            final place = exploreData!['hidden_gems'][index];
            return ExploreCard(place: place, isTopPick: false, index: index);
          }),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(icon, style: const TextStyle(fontSize: 20)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ExploreCard extends StatelessWidget {
  final Map<String, dynamic> place;
  final bool isTopPick;
  final int index;

  const ExploreCard({
    super.key,
    required this.place,
    required this.isTopPick,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFF667EEA),
      const Color(0xFF764BA2),
      const Color(0xFFF093FB),
      const Color(0xFFF5576C),
      const Color(0xFF4FACFE),
    ];

    final accentColor = colors[index % colors.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => PlaceDetailsPage(
                      place: place,
                      accentColor: accentColor,
                    ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Gradient accent
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [accentColor, accentColor.withOpacity(0.7)],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              place['title'] ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                          ),
                          if (isTopPick)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: accentColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'TOP PICK',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: accentColor,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(
                        place['description'] ?? '',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF4B5563),
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.location_on,
                              size: 16,
                              color: accentColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              place['location'] ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

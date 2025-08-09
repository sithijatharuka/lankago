// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:lankago/ask.dart';
// import 'package:lankago/features/PlaceDetailsPage/presentation/pages/place_details_page.dart'; // Make sure this is your Gemini API helper

// class ExplorePage extends StatefulWidget {
//   const ExplorePage({super.key});

//   @override
//   State<ExplorePage> createState() => _ExplorePageState();
// }

// class _ExplorePageState extends State<ExplorePage> {
//   bool loading = false;
//   Map<String, dynamic>? exploreData;

//   @override
//   void initState() {
//     super.initState();
//     generateExploreContent();
//   }

//   void generateExploreContent() async {
//     setState(() {
//       loading = true;
//     });

//     final prompt = '''
// You're a travel expert. Suggest top picks and hidden gems in Sri Lanka that are lesser known but worth visiting. Focus on unique, affordable, and authentic local experiences.

// Return only JSON in the following format:

// {
//   "top_picks": [
//     {
//       "title": "Place Name",
//       "description": "Short highlight about why it's great",
//       "location": "District or area"
//     }
//   ],
//   "hidden_gems": [
//     {
//       "title": "Place Name",
//       "description": "Short highlight about what makes it special",
//       "location": "District or area"
//     }
//   ]
// }
// Only return JSON. Do not explain.
// ''';

//     try {
//       final result = await askGemini(prompt);
//       final cleaned =
//           result.replaceAll('```json', '').replaceAll('```', '').trim();
//       final decoded = jsonDecode(cleaned);

//       setState(() {
//         exploreData = decoded;
//         loading = false;
//       });
//     } catch (e) {
//       setState(() {
//         exploreData = {"error": "Failed to load explore content: $e"};
//         loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Explore Sri Lanka')),
//       backgroundColor: const Color(0xFFF8FAFB),
//       body:
//           loading
//               ? _buildLoadingState()
//               : exploreData == null || exploreData!.containsKey('error')
//               ? _buildErrorState()
//               : _buildContent(),
//     );
//   }

//   Widget _buildLoadingState() {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.6,
//       width: double.infinity,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 20,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: const CircularProgressIndicator(
//               strokeWidth: 3,
//               valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF667EEA)),
//             ),
//           ),
//           const SizedBox(height: 24),
//           const Text(
//             'Discovering amazing places...',
//             style: TextStyle(
//               fontSize: 16,
//               color: Color(0xFF6B7280),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorState() {
//     return Container(
//       margin: const EdgeInsets.all(20),
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 20,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               color: const Color(0xFFFEF2F2),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: const Icon(
//               Icons.error_outline,
//               color: Color(0xFFEF4444),
//               size: 30,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             exploreData?['error'] ?? "Something went wrong",
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 16, color: Color(0xFF374151)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContent() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Top Picks Section
//           _buildSectionHeader(
//             icon: '✨',
//             title: 'Top Picks',
//             subtitle: 'Must-visit destinations',
//           ),
//           const SizedBox(height: 16),
//           ...List.generate(exploreData!['top_picks'].length, (index) {
//             final place = exploreData!['top_picks'][index];
//             return ExploreCard(place: place, isTopPick: true, index: index);
//           }),

//           const SizedBox(height: 40),

//           // Hidden Gems Section
//           _buildSectionHeader(
//             icon: '💎',
//             title: 'Hidden Gems',
//             subtitle: 'Off the beaten path',
//           ),
//           const SizedBox(height: 16),
//           ...List.generate(exploreData!['hidden_gems'].length, (index) {
//             final place = exploreData!['hidden_gems'][index];
//             return ExploreCard(place: place, isTopPick: false, index: index);
//           }),

//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionHeader({
//     required String icon,
//     required String title,
//     required String subtitle,
//   }) {
//     return Row(
//       children: [
//         Container(
//           width: 48,
//           height: 48,
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Center(
//             child: Text(icon, style: const TextStyle(fontSize: 20)),
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xFF1F2937),
//                 ),
//               ),
//               Text(
//                 subtitle,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: Color(0xFF6B7280),
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ExploreCard extends StatelessWidget {
//   final Map<String, dynamic> place;
//   final bool isTopPick;
//   final int index;

//   const ExploreCard({
//     super.key,
//     required this.place,
//     required this.isTopPick,
//     required this.index,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final colors = [
//       const Color(0xFF667EEA),
//       const Color(0xFF764BA2),
//       const Color(0xFFF093FB),
//       const Color(0xFFF5576C),
//       const Color(0xFF4FACFE),
//     ];

//     final accentColor = colors[index % colors.length];

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder:
//                     (context) => PlaceDetailsPage(
//                       place: place,
//                       accentColor: accentColor,
//                     ),
//               ),
//             );
//           },
//           borderRadius: BorderRadius.circular(20),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.06),
//                   blurRadius: 20,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Stack(
//               children: [
//                 // Gradient accent
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     height: 4,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [accentColor, accentColor.withOpacity(0.7)],
//                       ),
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Content
//                 Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               place['title'] ?? '',
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w700,
//                                 color: Color(0xFF1F2937),
//                               ),
//                             ),
//                           ),
//                           if (isTopPick)
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 4,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: accentColor.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Text(
//                                 'TOP PICK',
//                                 style: TextStyle(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w700,
//                                   color: accentColor,
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),

//                       const SizedBox(height: 12),

//                       Text(
//                         place['description'] ?? '',
//                         style: const TextStyle(
//                           fontSize: 15,
//                           color: Color(0xFF4B5563),
//                           height: 1.4,
//                         ),
//                       ),

//                       const SizedBox(height: 16),

//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(6),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFF3F4F6),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(
//                               Icons.location_on,
//                               size: 16,
//                               color: accentColor,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               place['location'] ?? '',
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Color(0xFF6B7280),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           Icon(
//                             Icons.arrow_forward_ios,
//                             size: 16,
//                             color: Colors.grey.withOpacity(0.5),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// newwwww

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lankago/features/PlaceDetailsPage/presentation/pages/place_details_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String? selectedDistrict;

  // Hardcoded data for all districts in Sri Lanka
  final Map<String, Map<String, dynamic>> districtData = {
    // CENTRAL PROVINCE
    "Kandy": {
      "top_picks": [
        {
          "title": "Temple of the Tooth",
          "description": "Houses Buddha's sacred tooth relic",
          "type": "Religious",
        },
        {
          "title": "Royal Botanical Gardens",
          "description": "Large collection of tropical plant species",
          "type": "Nature",
        },
      ],
      "cultural": [
        {
          "title": "Kandy Esala Perahera",
          "description": "Grand July/August festival with elephants",
          "type": "Festival",
        },
      ],
      "hidden_gems": [
        {
          "title": "Kandy Lake Walk",
          "description": "Peaceful lakeside stroll around the old city",
          "type": "Scenic",
        },
      ],
    },

    "Matale": {
      "top_picks": [
        {
          "title": "Aluvihare Rock Temple",
          "description": "Ancient Buddhist cave temple complex",
          "type": "Religious",
        },
        {
          "title": "Knuckles Range",
          "description": "Trekking through misty mountains and grasslands",
          "type": "Hiking",
        },
      ],
      "hidden_gems": [
        {
          "title": "Spice Gardens",
          "description": "Local plantations showcasing cinnamon, pepper",
          "type": "Agro-tourism",
        },
      ],
    },

    "Nuwara Eliya": {
      "top_picks": [
        {
          "title": "Horton Plains & World's End",
          "description": "Cliff-edge view over rolling tea country",
          "type": "Nature",
        },
        {
          "title": "Tea Plantations",
          "description": "Leaf-to-cup tours in lush estates",
          "type": "Agro-tourism",
        },
      ],
      "hidden_gems": [
        {
          "title": "Ramboda Falls",
          "description": "Multi-tiered waterfall along the hill roads",
          "type": "Scenic",
        },
      ],
    },

    // NORTH CENTRAL PROVINCE
    "Anuradhapura": {
      "top_picks": [
        {
          "title": "Sri Maha Bodhi",
          "description":
              "Sacred fig tree grown from Buddha's enlightenment tree",
          "type": "Religious",
        },
        {
          "title": "Jetavanaramaya",
          "description": "Largest ancient brick structure in the world",
          "type": "Archaeological",
        },
      ],
      "hidden_gems": [
        {
          "title": "Mihintale",
          "description": "Birthplace of Sri Lankan Buddhism; climb 1,840 steps",
          "type": "Hiking",
        },
      ],
    },

    "Polonnaruwa": {
      "top_picks": [
        {
          "title": "Gal Vihara",
          "description": "Rock-carved Buddha statues in meditation pose",
          "type": "Sculpture",
        },
        {
          "title": "Royal Palace Ruins",
          "description": "Palace remains of ancient capital",
          "type": "Historical",
        },
      ],
      "hidden_gems": [
        {
          "title": "Parakrama’s Pools",
          "description": "Ancient ceremonial bathing pools",
          "type": "Engineering",
        },
      ],
    },

    // NORTHERN PROVINCE
    "Jaffna": {
      "top_picks": [
        {
          "title": "Nallur Kandaswamy Temple",
          "description": "Major Hindu temple with annual festival",
          "type": "Religious",
        },
        {
          "title": "Jaffna Fort",
          "description": "Dutch-era fort with colonial architecture",
          "type": "Historical",
        },
      ],
      "hidden_gems": [
        {
          "title": "Delft Island",
          "description": "Remote coral island with wild horses",
          "type": "Adventure",
        },
      ],
    },

    "Kilinochchi": {
      "top_picks": [
        {
          "title": "Kilinochchi Lagoon",
          "description": "Tranquil backwaters, great for bird-watching",
          "type": "Nature",
        },
      ],
      "hidden_gems": [
        {
          "title": "Local Hindu Temples",
          "description": "Quiet countryside spiritual sites",
          "type": "Cultural",
        },
      ],
    },

    "Mannar": {
      "top_picks": [
        {
          "title": "Mannar Island",
          "description": "Bird-watching, baobab trees and coastal life",
          "type": "Nature",
        },
      ],
      "hidden_gems": [
        {
          "title": "Thalaimannar Windmills",
          "description": "Group of wind farms on the flat coast",
          "type": "Landscape",
        },
      ],
    },

    "Mullaitivu": {
      "top_picks": [
        {
          "title": "Mullaitivu Beaches",
          "description": "Undeveloped coastline and local fishing villages",
          "type": "Beach",
        },
      ],
      "hidden_gems": [
        {
          "title": "Community Turtle Projects",
          "description": "Conservation experiences with locals",
          "type": "Eco-tourism",
        },
      ],
    },

    "Vavuniya": {
      "top_picks": [
        {
          "title": "Vavuniya Ruins",
          "description": "Ancient temple and kantalai lake views",
          "type": "Historical",
        },
      ],
      "hidden_gems": [
        {
          "title": "Village Life Tours",
          "description": "Immersive experiences with local Tamils",
          "type": "Cultural",
        },
      ],
    },

    // EASTERN PROVINCE
    "Trincomalee": {
      "top_picks": [
        {
          "title": "Pigeon Island",
          "description": "Marine national park with coral reefs",
          "type": "Snorkeling",
        },
        {
          "title": "Koneswaram Temple",
          "description": "Clifftop Hindu temple with ocean views",
          "type": "Religious",
        },
      ],
      "hidden_gems": [
        {
          "title": "Nilaveli Beach",
          "description": "Long white-sand beach ideal for relaxation",
          "type": "Beach",
        },
      ],
    },

    "Ampara": {
      "top_picks": [
        {
          "title": "Senanayake Samudraya",
          "description": "Sri Lanka’s largest reservoir; boat rides",
          "type": "Scenic",
        },
      ],
      "hidden_gems": [
        {
          "title": "Kudumbigala Monastery",
          "description": "Ancient cliff retreat temples",
          "type": "Historical",
        },
      ],
    },

    "Batticaloa": {
      "top_picks": [
        {
          "title": "Batticaloa Lagoon",
          "description": "Lagoon boat tour and fish markets",
          "type": "Nature",
        },
      ],
      "hidden_gems": [
        {
          "title": "Pasikudah Beach",
          "description": "Quiet, shallow waters ideal for wading",
          "type": "Beach",
        },
      ],
    },

    // NORTH WESTERN PROVINCE
    "Kurunegala": {
      "top_picks": [
        {
          "title": "Kurunegala Rock Temple",
          "description": "Buddha statue carved on a giant rock",
          "type": "Religious",
        },
      ],
      "hidden_gems": [
        {
          "title": "Mini-Hill Hikes",
          "description": "Small trails with village views",
          "type": "Hiking",
        },
      ],
    },

    "Puttalam": {
      "top_picks": [
        {
          "title": "Kalpitiya",
          "description": "Dolphin & whale watching, kitesurfing",
          "type": "Adventure",
        },
      ],
      "hidden_gems": [
        {
          "title": "Bar Reef Marine Sanctuary",
          "description": "Snorkeling over untouched reefs",
          "type": "Marine",
        },
      ],
    },

    // SOUTHERN PROVINCE
    "Galle": {
      "top_picks": [
        {
          "title": "Galle Fort",
          "description": "UNESCO Dutch fortress with colonial charm",
          "type": "Historical",
        },
      ],
      "hidden_gems": [
        {
          "title": "Unawatuna Beach",
          "description": "White-sand bay popular for snorkeling",
          "type": "Beach",
        },
      ],
    },

    "Matara": {
      "top_picks": [
        {
          "title": "Mirissa Beach",
          "description": "Whale-watching and sunset views",
          "type": "Nature",
        },
      ],
      "hidden_gems": [
        {
          "title": "Polhena Turtle Beach",
          "description": "Natural reef pool with turtles",
          "type": "Marine",
        },
      ],
    },

    "Hambantota": {
      "top_picks": [
        {
          "title": "Yala National Park",
          "description": "Safari with elephants, leopards & birdlife",
          "type": "Wildlife",
        },
        {
          "title": "Bundala National Park",
          "description": "Coastal wetlands with migratory birds",
          "type": "Birdwatching",
        },
      ],
      "hidden_gems": [
        {
          "title": "Kumana Sanctuary",
          "description": "Remote beach and birdwatching sanctuary",
          "type": "Wildlife",
        },
      ],
    },

    // UVA PROVINCE
    "Badulla": {
      "top_picks": [
        {
          "title": "Mini World’s End, Madulsima",
          "description": "Cliff-edge views above tea estates",
          "type": "Scenic",
        },
      ],
      "hidden_gems": [
        {
          "title": "Riverston Trail",
          "description": "Highland plateau with forest & lakes",
          "type": "Hiking",
        },
      ],
    },

    "Monaragala": {
      "top_picks": [
        {
          "title": "Gal Oya Boat Safaris",
          "description": "Near wilderness lodges and elephant sightings",
          "type": "Adventure",
        },
      ],
      "hidden_gems": [
        {
          "title": "Buduruwagala Statues",
          "description": "Rock-cut Buddha figures in jungle",
          "type": "Sculpture",
        },
      ],
    },

    // SABARAGAMUWA PROVINCE
    "Kegalle": {
      "top_picks": [
        {
          "title": "Kelani River Rafting",
          "description": "Adventure rapids close to the hill country",
          "type": "Adventure",
        },
      ],
      "hidden_gems": [
        {
          "title": "Elephant Orphanage",
          "description": "Elephant care & feeding experience",
          "type": "Wildlife",
        },
      ],
    },

    "Ratnapura": {
      "top_picks": [
        {
          "title": "Gem Mines",
          "description": "Tours into working gem mines and markets",
          "type": "Cultural",
        },
      ],
      "hidden_gems": [
        {
          "title": "Sinharaja Rainforest",
          "description": "UNESCO Biosphere Reserve for birding",
          "type": "Nature",
        },
      ],
    },

    // WESTERN PROVINCE
    "Colombo": {
      "top_picks": [
        {
          "title": "Gangaramaya Temple",
          "description": "Architectural mix & Buddha relic chamber",
          "type": "Cultural",
        },
        {
          "title": "Galle Face Green",
          "description": "Oceanfront promenade & street food",
          "type": "Leisure",
        },
      ],
      "hidden_gems": [
        {
          "title": "Seema Malaka",
          "description": "Floating temple by Geoffrey Bawa",
          "type": "Architecture",
        },
      ],
    },

    "Gampaha": {
      "top_picks": [
        {
          "title": "Negombo Lagoon",
          "description": "Boat tours through mangroves and fish villages",
          "type": "Nature",
        },
      ],
      "hidden_gems": [
        {
          "title": "Muthurajawela Wetlands",
          "description": "Biodiverse wetland and marshlands",
          "type": "Eco-tourism",
        },
      ],
    },

    "Kalutara": {
      "top_picks": [
        {
          "title": "Kalutara Bodhiya",
          "description": "Sacred bodhi tree in a beachside temple",
          "type": "Religious",
        },
      ],
      "hidden_gems": [
        {
          "title": "Cinnamon Island Tour",
          "description": "Local spice garden and river backwaters",
          "type": "Agro-tourism",
        },
      ],
    },
  };

  List<String> get districts => districtData.keys.toList()..sort();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Sri Lanka'),
        backgroundColor: const Color(0xFF667EEA),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF8FAFB),
      body: Column(
        children: [
          // District Selector
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedDistrict,
                hint: const Text(
                  'Select a District',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF667EEA),
                ),
                items:
                    districts.map((String district) {
                      return DropdownMenuItem<String>(
                        value: district,
                        child: Text(
                          district,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F2937),
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
          ),

          // Content
          Expanded(
            child:
                selectedDistrict == null
                    ? _buildWelcomeScreen()
                    : _buildDistrictContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              ),
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(Icons.explore, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 32),
          const Text(
            'Discover Sri Lanka',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Select a district above to explore curated trip plans with top picks and hidden gems across the beautiful island of Sri Lanka.',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDistrictContent() {
    final data = districtData[selectedDistrict!]!;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // District Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_city, color: Colors.white, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedDistrict!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Curated travel experiences',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Top Picks Section
          _buildSectionHeader(
            icon: '✨',
            title: 'Top Picks',
            subtitle: 'Must-visit destinations',
          ),
          const SizedBox(height: 16),
          ...List.generate(data['top_picks'].length, (index) {
            final place = data['top_picks'][index];
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
          ...List.generate(data['hidden_gems'].length, (index) {
            final place = data['hidden_gems'][index];
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

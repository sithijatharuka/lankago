// import 'package:flutter/material.dart';
// import 'package:lankago/features/home/presentation/widgets/current_location.dart';
// import 'package:lankago/features/home/presentation/widgets/featured_destination_card.dart';
// import 'package:lankago/features/home/presentation/widgets/heading_text.dart';
// import 'package:lankago/features/home/presentation/widgets/popular_adv_item_list.dart';
// import 'package:lankago/features/home/presentation/widgets/search_bar.dart';
// import 'package:lankago/shared/widgets/app_bar.dart';

// class ExplorePage extends StatelessWidget {
//   const ExplorePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: appBar('Explore Sri Lanka'),

//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             spacing: 15,
//             children: [
//               Text(
//                 'Discover top places and local gems near you',
//                 style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
//               ),
//               searchBar(),
//               currentLocationSection(),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 160,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(
//                       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf8QAFTQIZqwo9lca0AfZbr-ewC_uGY__stg&s',
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),

//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 40,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     Chip(
//                       label: Text('All'),
//                       backgroundColor: Colors.red[500],
//                       labelStyle: TextStyle(color: Colors.white),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Chip(
//                         label: Text('Beaches'),
//                         backgroundColor: Colors.grey[300],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Chip(
//                         label: Text('Hiking'),
//                         backgroundColor: Colors.grey[300],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Chip(
//                         label: Text('Wildlife'),
//                         backgroundColor: Colors.grey[300],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               headingText('Top Picks for You'),
//               Container(
//                 height: 200,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 2,
//                   separatorBuilder: (context, index) => SizedBox(width: 12),
//                   itemBuilder: (context, index) {
//                     return featuredCard();
//                   },
//                 ),
//               ),
//               headingText('Hidden Gems Nearby'),
//               adventureList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

///*** */
///
import 'package:flutter/material.dart';
import 'package:lankago/features/explore/presentation/widgets/category_chip.dart';
import 'package:lankago/features/explore/presentation/widgets/custom_map.dart';
import 'package:lankago/features/home/presentation/widgets/current_location.dart';
import 'package:lankago/features/home/presentation/widgets/featured_destination_card.dart';
import 'package:lankago/features/home/presentation/widgets/heading_text.dart';
import 'package:lankago/features/home/presentation/widgets/popular_adv_item_list.dart';
import 'package:lankago/features/home/presentation/widgets/search_bar.dart';
import 'package:lankago/core/widgets/app_bar.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: appBar('Explore Sri Lanka'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Subtitle text
              Text(
                'Discover top places and local gems near you',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),

              // Search bar
              searchBar(),

              // Current location section
              currentLocationSection(),

              // Featured image banner
              CustomMap(),

              // Category filter chips
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryChip(label: 'All Alerts', isSelected: true),
                    const SizedBox(width: 12),
                    CategoryChip(label: 'Weather'),

                    //   buildCategoryChip('All', isSelected: true),
                    //   buildCategoryChip('Beaches'),
                    //   const SizedBox(width: 12),
                    //   buildCategoryChip('Hiking'),
                    //   const SizedBox(width: 12),
                    //   buildCategoryChip('Wildlife'),
                    //   const SizedBox(width: 12),
                    //   buildCategoryChip('Cultural'),
                    //   const SizedBox(width: 12),
                    //   buildCategoryChip('Adventure'),
                  ],
                ),
              ),

              // Top Picks section
              headingText('Top Picks for You'),

              SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 20),
                  itemCount: 5, // Increased count for better demo
                  separatorBuilder:
                      (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return SizedBox(width: 280, child: featuredCard());
                  },
                ),
              ),

              // Hidden Gems section
              headingText('Hidden Gems Nearby'),

              adventureList(),
            ],
          ),
        ),
      ),
    );
  }
}

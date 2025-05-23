import 'package:flutter/material.dart';
import 'package:lankago/features/home/presentation/widgets/current_location.dart';
import 'package:lankago/features/home/presentation/widgets/featured_destination_card.dart';
import 'package:lankago/features/home/presentation/widgets/heading_text.dart';
import 'package:lankago/features/home/presentation/widgets/popular_adv_item.dart';
import 'package:lankago/features/home/presentation/widgets/popular_adv_item_list.dart';
import 'package:lankago/features/home/presentation/widgets/search_bar.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Explore Sri Lanka'),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              Text(
                'Discover top places and local gems near you',
                style: TextStyle(fontSize: 14, color: Color(0xFFFF6B7280)),
              ),
              searchBar(),
              currentLocationSection(),
              Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 16,
                        right: 16,
                      ),
                      height: 36,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF6B00),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Beaches',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf8QAFTQIZqwo9lca0AfZbr-ewC_uGY__stg&s',
                        ),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 16,
                        right: 16,
                      ),
                      height: 36,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF6B00),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Beaches',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 12),
                  itemCount: 5,
                ),
              ),
              headingText('Top Picks for You'),
              Container(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  separatorBuilder: (context, index) => SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return featuredCard();
                  },
                ),
              ),
              headingText('Hidden Gems Nearby'),
              adventureList(),
            ],
          ),
        ),
      ),
    );
  }
}

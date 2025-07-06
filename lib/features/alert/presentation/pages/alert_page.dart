import 'package:flutter/material.dart';
import 'package:lankago/features/add_live_alert/presentation/live_alert_page.dart';
import 'package:lankago/features/alert/presentation/widgets/alert_card.dart';
import 'package:lankago/features/alert/presentation/widgets/tab_bar.dart';
import 'package:lankago/features/home/presentation/widgets/search_bar.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to alert creation page
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ReportLiveAlertScreen()),
            );
          },
          backgroundColor: Colors.red[500],
          child: Icon(Icons.add, color: Colors.white, size: 28),
        ),
        backgroundColor: Color(0xffF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'LankaGo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Container(
                  color: Color(0xffF8F9FA),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications, color: Colors.red[500]),
                      SizedBox(width: 8),
                      Text(
                        'Live Alerts',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Tab(
                child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.explore, color: Colors.red[500]),
                      SizedBox(width: 8),
                      Text(
                        'Experiences',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Column(
                    spacing: 15,
                    children: [
                      CustomSearchBar(),
                      CustomTabBar(),
                      //Alert Cards
                      AlertCard(),
                    ],
                  ),
                ),
              ),
            ),
            Center(child: Text('Favorites Page')),
          ],
        ),
      ),
    );
  }
}

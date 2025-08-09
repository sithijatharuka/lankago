import 'package:flutter/material.dart';
import 'package:lankago/features/add_live_alert/presentation/pages/live_alert_page.dart';
import 'package:lankago/features/alert/presentation/widgets/experiences_tab.dart';
import 'package:lankago/features/alert/presentation/widgets/live_alerts_tab.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LankaGo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.notifications_active), text: 'Live Alerts'),
            Tab(icon: Icon(Icons.explore), text: 'Experiences'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [LiveAlertsTab(), ExperiencesTab()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ReportLiveAlertScreen()),
          );
        },
        icon: const Icon(Icons.add_alert),
        label: const Text('Report Alert'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lankago/core/services/firestore_service.dart';
import 'package:lankago/core/widgets/app_bar.dart';
import 'package:lankago/features/add_live_alert/presentation/widgets/alert_type_selector.dart';
import 'package:lankago/features/add_live_alert/presentation/widgets/description_input.dart';
import 'package:lankago/features/add_live_alert/presentation/widgets/submit_button.dart';
import 'package:lankago/features/trip_planner/presentation/widgets/header_section.dart';

class ReportLiveAlertScreen extends StatefulWidget {
  const ReportLiveAlertScreen({super.key});

  @override
  State<ReportLiveAlertScreen> createState() => _ReportLiveAlertScreenState();
}

class _ReportLiveAlertScreenState extends State<ReportLiveAlertScreen> {
  String? selectedAlertType;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isSubmitting = false;

  final List<AlertType> alertTypes = [
    AlertType('Bad Weather', Icons.cloud_outlined, Colors.blue),
    AlertType('Road Block', Icons.warning_amber_outlined, Colors.orange),
    AlertType('Thunderstorm', Icons.flash_on_outlined, Colors.red),
    AlertType('Too Crowded', Icons.groups_outlined, Colors.purple),
    AlertType('Emergency', Icons.emergency_outlined, Colors.redAccent),
    AlertType(
      'Facility Issue',
      Icons.home_repair_service_outlined,
      Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: appBar('Report Live Alert'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderSection(),
            const SizedBox(height: 24),
            AlertTypeSelector(
              alertTypes: alertTypes,
              selectedType: selectedAlertType,
              onSelected: (type) {
                setState(() => selectedAlertType = type);
              },
            ),
            const SizedBox(height: 24),
            DescriptionInput(controller: _descriptionController),
            const SizedBox(height: 32),
            SubmitButton(isSubmitting: _isSubmitting, onPressed: ()=>{}),
          ],
        ),
      ),
    );
  }

  // final FirestoreService _firestoreService = FirestoreService();

  // void _handleSubmit() async {
  //   if (selectedAlertType == null) {
  //     _showSnack('Please select an alert type', Colors.orange);
  //     return;
  //   }
  //   if (_descriptionController.text.trim().isEmpty) {
  //     _showSnack('Please provide a description', Colors.orange);
  //     return;
  //   }

  //   setState(() => _isSubmitting = true);

  //   try {
  //     await _firestoreService.addAlert(
  //       selectedAlertType!,
  //       _descriptionController.text.trim(),
  //     );

  //     setState(() => _isSubmitting = false);

  //     _showSuccessDialog();
  //   } catch (e) {
  //     setState(() => _isSubmitting = false);
  //     _showSnack('Failed to submit alert: $e', Colors.red);
  //     print('Failed to submit alert: $e');
  //   }
  // }

  void _showSnack(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Alert Submitted'),
            content: const Text('Thank you for helping keep travelers safe!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('Done'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}

class AlertType {
  final String name;
  final IconData icon;
  final Color color;

  AlertType(this.name, this.icon, this.color);
}

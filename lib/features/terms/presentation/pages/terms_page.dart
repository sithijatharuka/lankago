import 'package:flutter/material.dart';
import 'package:lankago/core/widgets/app_bar.dart';
import 'package:lankago/features/terms/presentation/widgets/section_widgets.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Terms of Service'),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms of Service',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Last updated: August 2025',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 24),

            SectionWidget(
              title: '1. Acceptance of Terms',
              content:
                  'By using LankaGo, you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use our service.',
            ),

            SectionWidget(
              title: '2. Description of Service',
              content:
                  'LankaGo is a mobile application that provides travel and transportation services in Sri Lanka. We connect users with various travel options and information.',
            ),

            SectionWidget(
              title: '3. User Accounts',
              content:
                  'You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.',
            ),

            SectionWidget(
              title: '4. User Conduct',
              content:
                  'You agree not to use the service for any unlawful purpose or in any way that could damage, disable, or impair the service. Harassment of other users is strictly prohibited.',
            ),

            SectionWidget(
              title: '5. Privacy Policy',
              content:
                  'Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your information.',
            ),

            SectionWidget(
              title: '6. Intellectual Property',
              content:
                  'All content, features, and functionality of LankaGo are owned by us and are protected by copyright, trademark, and other intellectual property laws.',
            ),

            SectionWidget(
              title: '7. Disclaimers',
              content:
                  'LankaGo is provided "as is" without warranties of any kind. We do not guarantee that the service will be uninterrupted or error-free.',
            ),

            SectionWidget(
              title: '8. Limitation of Liability',
              content:
                  'We shall not be liable for any indirect, incidental, special, or consequential damages arising out of your use of the service.',
            ),

            SectionWidget(
              title: '9. Termination',
              content:
                  'We may terminate or suspend your account at any time, without prior notice, for conduct that we believe violates these Terms of Service.',
            ),

            SectionWidget(
              title: '10. Changes to Terms',
              content:
                  'We reserve the right to modify these terms at any time. We will notify users of any significant changes through the app or via email.',
            ),

            SectionWidget(
              title: '11. Contact Information',
              content:
                  'If you have any questions about these Terms of Service, please contact us at support@lankago.com',
            ),

            SizedBox(height: 32),

            Center(
              child: Text(
                '© 2025 LankaGo. All rights reserved.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

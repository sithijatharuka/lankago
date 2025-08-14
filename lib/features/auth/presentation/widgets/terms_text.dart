import 'package:flutter/material.dart';
import 'package:lankago/features/terms/presentation/pages/terms_page.dart';

class TermsText extends StatelessWidget {
  const TermsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(fontSize: 14, color: Colors.white70, height: 1.5),
          children: [
            const TextSpan(text: 'By continuing, you agree to our '),
            WidgetSpan(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TermsOfServicePage(),
                    ),
                  );

                  debugPrint("Terms of Service tapped");
                },
                child: const Text(
                  'Terms of Service and Privacy Policy',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

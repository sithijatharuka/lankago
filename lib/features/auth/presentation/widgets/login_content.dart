import 'package:flutter/material.dart';
import 'package:lankago/core/services/auth_service.dart';
import 'login_title.dart';
import 'login_subtitle.dart';
import 'terms_text.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginTitle(),
            const SizedBox(height: 16),
            const LoginSubtitle(),
            const SizedBox(height: 80),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  await signInWithGoogleAndGoHome(context);
                  print("Signed in successfully!");
                } catch (e) {
                  print("Error: $e");
                }
              },
              icon: Image.asset(
                'assets/images/icons/google.jpeg',
                height: 20,
                width: 20,
              ),
              label: const Text("Sign in with Google"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const TermsText(),
          ],
        ),
      ),
    );
  }
}

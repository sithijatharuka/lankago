import 'package:flutter/material.dart';
import 'google_signin_button.dart';
import 'login_title.dart';
import 'login_subtitle.dart';
import 'terms_text.dart';

class LoginContent extends StatelessWidget {
  final VoidCallback onGoogleSignIn;
  const LoginContent({required this.onGoogleSignIn, super.key});

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
            GoogleSignInButton(onPressed: onGoogleSignIn),
            const SizedBox(height: 40),
            const TermsText(),
          ],
        ),
      ),
    );
  }
}

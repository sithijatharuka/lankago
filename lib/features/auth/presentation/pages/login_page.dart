import 'package:flutter/material.dart';
import 'package:lankago/features/auth/presentation/widgets/background_image.dart';
import 'package:lankago/features/auth/presentation/widgets/login_content.dart';
import 'package:lankago/features/auth/presentation/widgets/overlay.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _handleGoogleSignIn(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Google Sign-In'),
            content: const Text(
              'Google Sign-In functionality would be implemented here.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to home or do actual sign-in logic
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          const CustomOverlay(),
          LoginContent(onGoogleSignIn: () => _handleGoogleSignIn(context)),
        ],
      ),
    );
  }
}

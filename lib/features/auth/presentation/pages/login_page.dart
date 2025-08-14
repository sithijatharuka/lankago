import 'package:flutter/material.dart';
import 'package:lankago/features/auth/presentation/widgets/background_image.dart';
import 'package:lankago/features/auth/presentation/widgets/login_content.dart';
import 'package:lankago/features/auth/presentation/widgets/overlay.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          const CustomOverlay(),
          LoginContent(),
        ],
      ),
    );
  }
}

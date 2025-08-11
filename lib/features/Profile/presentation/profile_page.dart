import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lankago/core/widgets/app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar('Profile'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // Profile Picture
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    user?.photoURL ?? 'https://via.placeholder.com/150',
                  ),
                ),

                const SizedBox(height: 24),

                // Name
                Text(
                  user?.displayName ?? 'Guest User',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                // Email
                Text(
                  user?.email ?? 'No email available',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            // Bottom section with app info and sign out
            buildAppDetails(context),
          ],
        ),
      ),
    );
  }

  Column buildAppDetails(BuildContext context) {
    return Column(
      children: [
        const Text(
          'LankaGo v1.0.0',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Developed by Sithija Tharuka',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        const Text(
          '© 2025 All Rights Reserved',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 32),

        // Sign Out Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () => _showSignOutDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5722),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout, size: 20),
                SizedBox(width: 8),
                Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleSignOut(context);
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Color(0xFFFF5722)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleSignOut(BuildContext context) {
    GoogleSignIn()
        .signOut()
        .then((_) {
          return FirebaseAuth.instance.signOut();
        })
        .then((_) {
          // Now safe to use context synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Signed out successfully'),
              backgroundColor: Color(0xFFFF5722),
            ),
          );
          Navigator.of(context).pushReplacementNamed('/login');
        });
  }
}

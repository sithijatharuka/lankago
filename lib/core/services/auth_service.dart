import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:go_router/go_router.dart';

Future<void> signInWithGoogleAndGoHome(BuildContext context) async {
  try {
    // Trigger the Google sign-in flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return; // User canceled sign-in

    // Get the auth details from Google
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential for Firebase
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in with Firebase
    await FirebaseAuth.instance.signInWithCredential(credential);

    // Navigate to Home
    context.go('/home'); // or context.goNamed('home');
  } catch (e) {
    print("Sign in failed: $e");
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Sign in failed: $e")));
  }
}

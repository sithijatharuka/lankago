import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar homeAppBar(BuildContext context, User? user) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: const Text(
      'LankaGo',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: [
      Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(right: 16),
        child: GestureDetector(
          onTap: () => context.pushNamed('/profile'),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              user?.photoURL ?? 'https://via.placeholder.com/150',
            ),
          ),
        ),
      ),
    ],
  );
}

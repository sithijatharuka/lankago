import 'package:flutter/material.dart';

AppBar appBar(String title) {
  return AppBar(
    title: Text(title),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
  );
}

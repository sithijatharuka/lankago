import 'package:flutter/material.dart';

Container buildTabBar(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 40,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Chip(
            label: Text('All Alerts'),
            backgroundColor: Colors.red[500],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Chip(
            label: Text('Road Issues'),
            backgroundColor: Colors.grey[300],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Chip(
            label: Text('Weather'),
            backgroundColor: Colors.grey[300],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Chip(
            label: Text('Emergency'),
            backgroundColor: Colors.grey[300],
          ),
        ),
      ],
    ),
  );
}

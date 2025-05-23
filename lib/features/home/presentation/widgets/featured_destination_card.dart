import 'package:flutter/material.dart';

Container featuredCard() {
  return Container(
    height: 200,
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      image: DecorationImage(
        image: NetworkImage(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwXCpb0Kd4KzDmdEtQsDURYNiv6mo4cCEMqQ&s',
        ),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sigiriya Rock',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 20),
              SizedBox(width: 4),
              Text('4.8', style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';

Container buildShareButton() {
  return Container(
    width: double.infinity,
    height: 42,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xffE5E7EB), width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      child: Text(
        'Share Plan',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

Widget buildTextField({
  required String hint,
  required TextEditingController controller,
  required IconData icon,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFF9FAFB),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Color(0xFFE5E7EB), width: 1),
    ),
    child: TextField(
      controller: controller,
      style: TextStyle(
        fontSize: 16,
        color: Color(0xFF111827),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Color(0xFF6B7280),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(icon, color: Color(0xFF6B7280), size: 22),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    ),
  );
}

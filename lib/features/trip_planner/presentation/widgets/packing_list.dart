import 'package:flutter/material.dart';

Container buildPackingList(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,

    decoration: BoxDecoration(
      color: Color(0xFFF9FAFB),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE5E7EB)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (bool? value) {},
                activeColor: Color(0xFFFF5722),
              ),
              Text(
                'Passport & Travel Documents',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (bool? value) {},
                activeColor: Color(0xFFFF5722),
              ),
              Text(
                'Cash & Cards',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 42,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFFFF5722), width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              child: Text(
                'Add Item',
                style: TextStyle(
                  color: Color(0xFFFF5722),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

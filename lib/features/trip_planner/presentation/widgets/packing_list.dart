import 'package:flutter/material.dart';

class PackingList extends StatefulWidget {
  const PackingList({super.key});

  @override
  State<PackingList> createState() => _PackingListState();
}

class _PackingListState extends State<PackingList> {
  // Checkbox states
  bool _passportChecked = false;
  bool _cashChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: _passportChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _passportChecked = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFFFF5722),
                ),
                const Text(
                  'Passport & Travel Documents',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _cashChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _cashChecked = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFFFF5722),
                ),
                const Text(
                  'Cash & Cards',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                onPressed: () {
                  // Add your add item logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color(0xFFFF5722),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
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
}

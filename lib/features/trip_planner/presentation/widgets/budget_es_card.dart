// import 'package:flutter/material.dart';

// Container buildbudgetEstimator(BuildContext context) {
//   return Container(
//     width: MediaQuery.of(context).size.width,

//     decoration: BoxDecoration(
//       color: Color(0xFFF9FAFB),
//       borderRadius: BorderRadius.circular(12),
//       border: Border.all(color: Color(0xFFE5E7EB)),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Total Estimated',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                   color: Color(0xff4B5563),
//                 ),
//               ),
//               Text(
//                 'Rs 20,000',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 20,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//           ListTile(
//             contentPadding: EdgeInsets.all(0),
//             title: Text('Accommodation'),
//             trailing: Text('Rs 10,000'),
//           ),
//           ListTile(
//             contentPadding: EdgeInsets.all(0),
//             title: Text('Transport'),
//             trailing: Text('Rs 10,000'),
//           ),
//           ListTile(
//             contentPadding: EdgeInsets.all(0),
//             title: Text('Food & Drinks'),
//             trailing: Text('Rs 10,000'),
//           ),
//           ListTile(
//             contentPadding: EdgeInsets.all(0),
//             title: Text('Activities'),
//             trailing: Text('Rs 10,000'),
//           ),
//         ],
//       ),
//     ),
//   );
// }

import 'dart:ui';

import 'package:flutter/material.dart';

class BudgetCard extends StatelessWidget {
  final Map<String, dynamic> budget;

  const BudgetCard({required this.budget, super.key});

  @override
  Widget build(BuildContext context) {
    final total = budget.values.fold<double>(
      0,
      (sum, val) => sum + (val is num ? val.toDouble() : 0),
    );

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFE5E7EB).withOpacity(0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Estimated',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF6B7280),
                  ),
                ),
                Text(
                  'Rs ${total.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Color(0xFFFF5722),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ..._buildBudgetItems(budget),
        ],
      ),
    );
  }

  List<Widget> _buildBudgetItems(Map<String, dynamic> budget) {
    return budget.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              entry.key,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Rs ${entry.value}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

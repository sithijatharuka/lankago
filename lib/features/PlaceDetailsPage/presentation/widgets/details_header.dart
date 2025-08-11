// import 'package:flutter/material.dart';

// class DetailsHeader extends StatelessWidget {
//   final Map<String, dynamic> place;
//   final Map<String, dynamic> details;

//   const DetailsHeader({super.key, required this.place, required this.details});

//   // Helper method to safely convert any value to string
//   String _safeToString(dynamic value) {
//     if (value == null) return 'N/A';
//     if (value is String) return value;
//     if (value is Map) return value.toString();
//     if (value is List) return value.join(', ');
//     return value.toString();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.blue.shade50,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.blue.shade200, width: 1),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Location with icon
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailItem(
//     IconData icon,
//     String label,
//     String value,
//     MaterialColor color,
//   ) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: color.shade50,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: color.shade200, width: 1),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, color: color.shade700, size: 16),
//               const SizedBox(width: 4),
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: color.shade700,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: color.shade900,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

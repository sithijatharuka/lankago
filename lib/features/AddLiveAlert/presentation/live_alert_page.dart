import 'package:flutter/material.dart';
import 'package:lankago/features/home/presentation/widgets/button.dart';
import 'package:lankago/features/home/presentation/widgets/heading_text.dart';
import 'package:lankago/shared/widgets/app_bar.dart';

class ReportLiveAlertScreen extends StatelessWidget {
  const ReportLiveAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Report a Live Alert'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(6, (index) {
                  return Container(
                    height: 56,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xffEFF6FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.cloud, color: Color(0xff2563EB)),
                        SizedBox(width: 10),
                        Text(
                          'Bad Weather',
                          style: TextStyle(
                            color: Color(0xff2563EB),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              TextField(          
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Describe what's happening...",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xff0066CC)),
                  ),
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              headingText('Location'),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf8QAFTQIZqwo9lca0AfZbr-ewC_uGY__stg&s',
                    ),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0066CC),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: Text(
                    'Submit Alert',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class ReportLiveAlertScreen extends StatefulWidget {
//   const ReportLiveAlertScreen({super.key});

//   @override
//   State<ReportLiveAlertScreen> createState() => _ReportLiveAlertScreenState();
// }

// class _ReportLiveAlertScreenState extends State<ReportLiveAlertScreen> {
//   String? selectedAlertType;
//   TextEditingController descriptionController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Title
//               Text(
//                 'Report a Live Alert',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 30),

//               // Alert Type Buttons Grid
//               GridView.count(
//                 crossAxisCount: 2,
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 crossAxisSpacing: 15,
//                 mainAxisSpacing: 15,
//                 childAspectRatio: 2.5,
//                 children: [
//                   _buildAlertButton(
//                     'Bad Weather',
//                     Icons.cloud_outlined,
//                     Colors.blue,
//                     Colors.blue.shade50,
//                   ),
//                   _buildAlertButton(
//                     'Road Block',
//                     Icons.warning_outlined,
//                     Colors.orange,
//                     Colors.orange.shade50,
//                   ),
//                   _buildAlertButton(
//                     'Thunderstorm',
//                     Icons.thunderstorm_outlined,
//                     Colors.red,
//                     Colors.red.shade50,
//                   ),
//                   _buildAlertButton(
//                     'Too Crowded',
//                     Icons.groups_outlined,
//                     Colors.amber.shade700,
//                     Colors.amber.shade50,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15),

//               // Emergency Button (Full Width)
//               Container(
//                 width: double.infinity,
//                 child: _buildAlertButton(
//                   'Emergency',
//                   Icons.circle,
//                   Colors.red,
//                   Colors.red.shade50,
//                   isFullWidth: true,
//                 ),
//               ),
//               SizedBox(height: 30),

//               // Description TextField
//               Container(
//                 height: 120,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: TextField(
//                   controller: descriptionController,
//                   maxLines: null,
//                   expands: true,
//                   textAlignVertical: TextAlignVertical.top,
//                   decoration: InputDecoration(
//                     hintText: "Describe what's happening...",
//                     hintStyle: TextStyle(
//                       color: Colors.grey.shade500,
//                       fontSize: 16,
//                     ),
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.all(16),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),

//               // Location Section
//               Text(
//                 'Location',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 15),

//               // Map Container
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Stack(
//                     children: [
//                       // Mock map background
//                       Container(
//                         color: Colors.grey.shade100,
//                         child: CustomPaint(
//                           painter: MapPainter(),
//                           size: Size.infinite,
//                         ),
//                       ),
//                       Center(
//                         child: Text(
//                           'Map Preview',
//                           style: TextStyle(color: Colors.grey, fontSize: 16),
//                         ),
//                       ),
//                       // Map pins
//                       Positioned(
//                         left: 60,
//                         top: 80,
//                         child: Icon(
//                           Icons.location_on,
//                           color: Colors.red,
//                           size: 30,
//                         ),
//                       ),
//                       Positioned(
//                         right: 80,
//                         top: 60,
//                         child: Icon(
//                           Icons.location_on,
//                           color: Colors.red,
//                           size: 30,
//                         ),
//                       ),
//                       Positioned(
//                         right: 60,
//                         bottom: 40,
//                         child: Icon(
//                           Icons.location_on,
//                           color: Colors.red,
//                           size: 30,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 15),

//               // Change Location Button
//               Center(
//                 child: TextButton(
//                   onPressed: () {
//                     // Handle change location
//                   },
//                   child: Text(
//                     'Change Location',
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),

//               SizedBox(height: 30),

//               // Submit Button
//               Container(
//                 width: double.infinity,
//                 height: 56,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     _showSubmitDialog();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     'Submit Alert',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAlertButton(
//     String label,
//     IconData icon,
//     Color iconColor,
//     Color backgroundColor, {
//     bool isFullWidth = false,
//   }) {
//     bool isSelected = selectedAlertType == label;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedAlertType = label;
//         });
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: isSelected ? iconColor.withOpacity(0.1) : backgroundColor,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected ? iconColor : Colors.transparent,
//             width: 2,
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Row(
//             children: [
//               Icon(icon, color: iconColor, size: 24),
//               SizedBox(width: 10),
//               Expanded(
//                 child: Text(
//                   label,
//                   style: TextStyle(
//                     color: iconColor,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showSubmitDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Alert Submitted'),
//           content: Text('Your live alert has been submitted successfully!'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     descriptionController.dispose();
//     super.dispose();
//   }
// }

// class MapPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint =
//         Paint()
//           ..color = Colors.grey.shade300
//           ..strokeWidth = 1;

//     for (int i = 0; i < size.width; i += 40) {
//       canvas.drawLine(
//         Offset(i.toDouble(), 0),
//         Offset(i.toDouble(), size.height),
//         paint,
//       );
//     }

//     for (int i = 0; i < size.height; i += 40) {
//       canvas.drawLine(
//         Offset(0, i.toDouble()),
//         Offset(size.width, i.toDouble()),
//         paint,
//       );
//     }

//     final parkPaint = Paint()..color = Colors.green.shade200;
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(
//           size.width * 0.6,
//           size.height * 0.1,
//           size.width * 0.3,
//           size.height * 0.25,
//         ),
//         Radius.circular(8),
//       ),
//       parkPaint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

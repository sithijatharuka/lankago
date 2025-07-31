// import 'package:flutter/material.dart';

// class CurrentLocationSection extends StatelessWidget {
//   const CurrentLocationSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(Icons.location_on, color: Colors.blue, size: 20),
//         SizedBox(width: 8),
//         Text(
//           'Current Location: Colombo',
//           style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CurrentLocationSection extends StatefulWidget {
  const CurrentLocationSection({super.key});

  @override
  State<CurrentLocationSection> createState() => _CurrentLocationSectionState();
}

class _CurrentLocationSectionState extends State<CurrentLocationSection> {
  String locationText = 'Getting your city...';

  @override
  void initState() {
    super.initState();
    _getCityFromLocation();
  }

  Future<void> _getCityFromLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationText = 'Location services are disabled.';
      });
      return;
    }

    // Check and request location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationText = 'Location permissions are denied.';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationText = 'Permissions are permanently denied.';
      });
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    try {
      // Reverse geocoding to get placemarks
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final city = placemarks[0].locality ?? 'Unknown city';
        setState(() {
          locationText = 'Current Location: $city';
        });
      } else {
        setState(() {
          locationText = 'City not found';
        });
      }
    } catch (e) {
      setState(() {
        locationText = 'Error getting city: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on, color: Colors.blue, size: 20),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            locationText,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}

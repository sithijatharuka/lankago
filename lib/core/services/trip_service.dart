import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Getting the Current User’s Trip Plans Collection
  CollectionReference<Map<String, dynamic>> get _tripPlansRef {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");
    return _db.collection('users').doc(uid).collection('trip_plans');
  }

  // Listening to Trip Plans in Real Time
  Stream<QuerySnapshot<Map<String, dynamic>>> getTripsStream() {
    return _tripPlansRef.orderBy('createdAt', descending: true).snapshots();
  }

  // Adding a Trip Plan
  Future<void> addTripPlan({
    required String tripName,
    required String district,
    required DateTime startDate,
    required DateTime endDate,
    required Map<String, dynamic> itinerary,
    required Map<String, dynamic> budget,
    required List<String> packingList,
  }) async {
    await _tripPlansRef.add({
      'tripName': tripName,
      'district': district,
      'startDate': startDate,
      'endDate': endDate,
      'createdAt': FieldValue.serverTimestamp(),
      'itinerary': itinerary,
      'budget': budget,
      'packingList': packingList,
    });
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirestoreService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   // Reference to user's alerts collection
//   CollectionReference<Map<String, dynamic>> get _alertsRef {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null) throw Exception("User not logged in");
//     return _db.collection('users').doc(uid).collection('alerts');
//   }

//   // CREATE - add a new alert
//   Future<void> addAlert(String type, String description) async {
//     await _alertsRef.add({
//       'type': type,
//       'description': description,
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//   }

//   // READ - get all alerts stream
//   Stream<QuerySnapshot<Map<String, dynamic>>> getAlertsStream() {
//     return _alertsRef.orderBy('createdAt', descending: true).snapshots();
//   }

//   // UPDATE - update an existing alert
//   Future<void> updateAlert(
//     String docId,
//     String type,
//     String description,
//   ) async {
//     await _alertsRef.doc(docId).update({
//       'type': type,
//       'description': description,
//       'updatedAt': FieldValue.serverTimestamp(),
//     });
//   }

//   // DELETE - delete an alert by document ID
//   Future<void> deleteAlert(String docId) async {
//     await _alertsRef.doc(docId).delete();
//   }
// }

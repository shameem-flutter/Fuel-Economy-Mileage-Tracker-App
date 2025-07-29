import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/models/trip_model.dart';

class TripService {
  static final _fireStore = FirebaseFirestore.instance;
  static Future<void> addTrip(TripModel trip) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      await _fireStore
          .collection('users')
          .doc(uid)
          .collection('trips')
          .doc(trip.id)
          .set(trip.toMap());
    } catch (e) {
      print("Trip Upload failed:$e");
    }
  }

  static Future<List<TripModel>> getTrips() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await _fireStore
        .collection('users')
        .doc(uid)
        .collection('trips')
        .orderBy('date', descending: true)
        .get();
    return snapshot.docs.map((doc) => TripModel.fromMap(doc.data())).toList();
  }
}

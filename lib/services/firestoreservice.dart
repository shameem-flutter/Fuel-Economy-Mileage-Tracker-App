import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/models/trip_model.dart';

class Firestoreservice {}

final _tripCollection = FirebaseFirestore.instance.collection('trips');
Future<void> addTrip(TripModel trip) async {
  await _tripCollection.doc(trip.id).set(trip.toMap());
}

Stream<List<TripModel>> getTrips() {
  return _tripCollection
      .orderBy('date', descending: true)
      .snapshots()
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => TripModel.fromMap(doc.data())).toList(),
      );
}

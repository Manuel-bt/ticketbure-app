import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference events =
      FirebaseFirestore.instance.collection('events');

  Future<void> addEvent(Map<String, dynamic> eventData) async {
    await events.add(eventData);
  }

  Stream<QuerySnapshot> getEvents() {
    return events.snapshots();
  }
}
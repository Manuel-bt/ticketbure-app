import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/services/firestore_service.dart';
import '../../organizer/screens/create_event_screen.dart';
import 'event_details_screen.dart';

class HomeMapScreen extends StatefulWidget {
  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  GoogleMapController? mapController;

  final firestoreService = FirestoreService();

  Set<Marker> buildMarkers(List docs) {
    return docs.map((doc) {
      final event = doc.data() as Map<String, dynamic>;

      return Marker(
        markerId: MarkerId(doc.id),
        position: LatLng(
          (event["lat"] as num).toDouble(),
          (event["lng"] as num).toDouble(),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EventDetailsScreen(event: event),
            ),
          );
        },
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateEventScreen(
                onCreate: (_) {},
              ),
            ),
          );
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-6.7924, 39.2083),
              zoom: 13,
            ),
            onMapCreated: (controller) {
              mapController = controller;
            },
            markers: buildMarkers(docs),
          );
        },
      ),
    );
  }
}
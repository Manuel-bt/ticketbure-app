import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../organizer/screens/create_event_screen.dart';
import 'event_details_screen.dart';

class HomeMapScreen extends StatefulWidget {
  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  GoogleMapController? mapController;

  List<Map<String, dynamic>> events = [
    {
      "title": "Beach Festival",
      "location": "Kigamboni",
      "price": "TZS 50,000",
      "lat": -6.8265,
      "lng": 39.2804,
      "image":
          "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
    },
    {
      "title": "Amapiano Night",
      "location": "Masaki",
      "price": "TZS 20,000",
      "lat": -6.7460,
      "lng": 39.2890,
      "image":
          "https://images.unsplash.com/photo-1514525253161-7a46d19cd819",
    },
  ];

  void addEvent(Map<String, dynamic> event) {
    setState(() {
      events.add({
        ...event,
        "image":
            "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
      });
    });
  }

  Set<Marker> buildMarkers() {
    return events.map((event) {
      return Marker(
        markerId: MarkerId(event["title"]),
        position: LatLng(event["lat"], event["lng"]),
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
              builder: (_) => CreateEventScreen(onCreate: addEvent),
            ),
          );
        },
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.7924, 39.2083),
          zoom: 13,
        ),
        onMapCreated: (controller) {
          mapController = controller;
        },
        markers: buildMarkers(),
      ),
    );
  }
}q
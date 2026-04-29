import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(TicketBureApp());
}

class TicketBureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TicketBure',
      theme: ThemeData.dark(),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LatLng darEsSalaam = const LatLng(-6.7924, 39.2083);

  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId("masaki"),
      position: LatLng(-6.7469, 39.2753),
      infoWindow: InfoWindow(
        title: "Amapiano Night",
        snippet: "TZS 20,000",
      ),
    ),
    Marker(
      markerId: MarkerId("mlimani"),
      position: LatLng(-6.7833, 39.2333),
      infoWindow: InfoWindow(
        title: "Tech Meetup",
        snippet: "Free",
      ),
    ),
    Marker(
      markerId: MarkerId("kigamboni"),
      position: LatLng(-6.8500, 39.3500),
      infoWindow: InfoWindow(
        title: "Beach Festival",
        snippet: "TZS 50,000",
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: darEsSalaam,
              zoom: 12,
            ),
            markers: _markers,
          ),

          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "What's happening in Dar tonight?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Beach Festival",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Kigamboni • TZS 50,000"),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Buy Ticket"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
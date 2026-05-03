import 'package:flutter/material.dart';
import 'payment_screen.dart';
import '../../organizer/screens/create_event_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeMapScreen extends StatefulWidget {
  const HomeMapScreen({super.key});

  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  String eventName = "Beach Festival";
  String eventLocation = "Kigamboni";
  String eventPrice = "TZS 50,000";
  GoogleMapController? mapController;

  Set<Marker> buildMarkers() {
    return events.map((event) {
      return Marker(
        markerId: MarkerId(event["title"]),
        position: LatLng(
          -6.79 + (events.indexOf(event) * 0.01),
          39.20 + (events.indexOf(event) * 0.01),
        ),
        infoWindow: InfoWindow(
          title: event["title"],
          snippet: event["price"],
          onTap: () {
            updateEvent(
              event["title"],
              event["location"],
              event["price"],
              event["image"],
            );
          },
        ),
      );
    }).toSet();
  }

  void updateEvent(String name, String location, String price, String image) {
    setState(() {
      eventName = name;
      eventLocation = location;
      eventPrice = price;
      eventImage = image;
    });
  }

  void addEvent(Map<String, String> event) {
    setState(() {
      events.add({
        ...event,
        "top": (200 + events.length * 40).toDouble(),
        "left": (50 + events.length * 60).toDouble(),
        "color": Colors.blue,
      });
    });
  }

  List<Map<String, dynamic>> events = [
    {
      "title": "Beach Festival",
      "location": "Kigamboni",
      "price": "TZS 50,000",
      "top": 450.0,
      "left": 220.0,
      "color": Colors.orange,
      "image": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
    },
    {
      "title": "Amapiano Night",
      "location": "Masaki",
      "price": "TZS 20,000",
      "top": 220.0,
      "left": 80.0,
      "color": Colors.purple,
      "image": "https://images.unsplash.com/photo-1514525253161-7a46d19cd819",
    },
    {
      "title": "Tech Meetup",
      "location": "Mlimani City",
      "price": "FREE",
      "top": 350.0,
      "left": 100.0,
      "color": Colors.green,
      "image": "https://images.unsplash.com/photo-1551836022-d5d88e9218df",
    },
  ];

  String eventImage =
      "https://images.unsplash.com/photo-1507525428034-b723cf961d3e";

  void goToPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          eventName: eventName,
          eventLocation: eventLocation,
          eventPrice: eventPrice,
        ),
      ),
    );
  }

  Widget buildPin({
    required double top,
    required double left,
    double? right,
    required Color color,
    required String name,
    required String location,
    required String price,
    required String image,
  }) {
    return Positioned(
      top: top,
      left: right == null ? left : null,
      right: right,
      child: GestureDetector(
        onTap: () {
          updateEvent(name, location, price, image);
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(Icons.location_on, color: Colors.white, size: 28),
            ),
            SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Text(
              "What's happening in Dar tonight?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-6.7924, 39.2083),
              zoom: 13,
            ),
            onMapCreated: (controller) {
              mapController = controller;
            },
            markers: buildMarkers(),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          ...events.map((event) {
            return buildPin(
              top: event["top"],
              left: event["left"],
              color: event["color"],
              name: event["title"],
              location: event["location"],
              price: event["price"],
              image: event["image"],
            );
          }),

          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        eventImage,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      eventName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      eventLocation,
                      style: TextStyle(color: Colors.white70),
                    ),

                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          eventPrice,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellowAccent,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: goToPayment,
                          child: Text("Buy"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateEventScreen(onCreate: addEvent),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

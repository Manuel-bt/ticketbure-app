import 'package:flutter/material.dart';

void main() {
  runApp(TicketBureApp());
}

class TicketBureApp extends StatelessWidget {
  const TicketBureApp({super.key});

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
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String eventName = "Beach Festival";
  String eventLocation = "Kigamboni";
  String eventPrice = "TZS 50,000";

  void updateEvent(String name, String location, String price) {
    setState(() {
      eventName = name;
      eventLocation = location;
      eventPrice = price;
    });
  }

  Widget buildPin({
    required double top,
    required double left,
    double? right,
    required Color color,
    required String name,
    required String location,
    required String price,
  }) {
    return Positioned(
      top: top,
      left: right == null ? left : null,
      right: right,
      child: GestureDetector(
        onTap: () {
          updateEvent(name, location, price);
        },
        child: Column(
          children: [
            Icon(
              Icons.location_on,
              color: color,
              size: 50,
            ),
            Text(
              price,
              style: TextStyle(color: Colors.white),
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
          // Background map image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1577948000111-9c970dfe3743?q=80&w=1200",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            color: Colors.black.withOpacity(0.35),
          ),

          // Interactive Pins
          buildPin(
            top: 220,
            left: 80,
            color: Colors.purple,
            name: "Amapiano Night",
            location: "Masaki",
            price: "TZS 20,000",
          ),

          buildPin(
            top: 350,
            left: 0,
            right: 100,
            color: Colors.green,
            name: "Tech Meetup",
            location: "Mlimani City",
            price: "FREE",
          ),

          buildPin(
            top: 450,
            left: 220,
            color: Colors.orange,
            name: "Beach Festival",
            location: "Kigamboni",
            price: "TZS 50,000",
          ),

          // Search bar
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "What's happening in Dar tonight?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Dynamic event card
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    eventName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "$eventLocation • $eventPrice",
                    style: TextStyle(fontSize: 18),
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Buy Ticket",
                      style: TextStyle(fontSize: 18),
                    ),
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
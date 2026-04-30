import 'package:flutter/material.dart';
import 'payment_screen.dart';
import '../../organizer/screens/create_event_screen.dart';

class HomeMapScreen extends StatefulWidget {
  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
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

  void addEvent(Map<String, String> event) {
    setState(() {
      events.add(event);
    });
  }

  List<Map<String, String>> events = [
    {"title": "Beach Festival", "location": "Kigamboni", "price": "TZS 50,000"},
  ];

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
            Icon(Icons.location_on, color: color, size: 50),
            Text(price),
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
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1577948000111-9c970dfe3743?q=80&w=1200",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(color: Colors.black.withOpacity(0.4)),

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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text("$eventLocation • $eventPrice"),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: goToPayment,
                    child: Text("Buy Ticket"),
                  ),
                ],
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

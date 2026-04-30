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
    },
    {
      "title": "Amapiano Night",
      "location": "Masaki",
      "price": "TZS 20,000",
      "top": 220.0,
      "left": 80.0,
      "color": Colors.purple,
    },
    {
      "title": "Tech Meetup",
      "location": "Mlimani City",
      "price": "FREE",
      "top": 350.0,
      "left": 100.0,
      "color": Colors.green,
    },
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
    Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
          )
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
    )
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
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
),
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
            );
          }).toList(),

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
        )
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eventName,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 6),

        Text(
          eventLocation,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: goToPayment,
              child: Text("Buy"),
            )
          ],
        )
      ],
    ),
  ),
)
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

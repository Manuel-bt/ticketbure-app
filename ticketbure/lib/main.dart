import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("$eventLocation • $eventPrice"),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: goToPayment,
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

class PaymentScreen extends StatelessWidget {
  final String eventName;
  final String eventLocation;
  final String eventPrice;

  PaymentScreen({
    required this.eventName,
    required this.eventLocation,
    required this.eventPrice,
  });

  void completePayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketScreen(
          eventName: eventName,
          eventLocation: eventLocation,
          eventPrice: eventPrice,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => completePayment(context),
          child: Text("Complete Payment"),
        ),
      ),
    );
  }
}

class TicketScreen extends StatelessWidget {
  final String eventName;
  final String eventLocation;
  final String eventPrice;

  TicketScreen({
    required this.eventName,
    required this.eventLocation,
    required this.eventPrice,
  });

  void goToScanner(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScannerScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Ticket"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              eventName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text("$eventLocation • $eventPrice"),

            SizedBox(height: 20),

            QrImageView(
              data: eventName,
              size: 200,
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => goToScanner(context),
              child: Text("Simulate Entry Scan"),
            )
          ],
        ),
      ),
    );
  }
}

class ScannerScreen extends StatelessWidget {
  void validateTicket(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Ticket Verified ✅"),
        content: Text("Entry Approved"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Done"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organizer Scanner"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => validateTicket(context),
          child: Text("Scan Ticket"),
        ),
      ),
    );
  }
}
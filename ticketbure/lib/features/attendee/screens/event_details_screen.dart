import 'package:flutter/material.dart';
import 'payment_screen.dart';

class EventDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> event;

  EventDetailsScreen({required this.event});

  void goToPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentScreen(
          eventName: event["title"],
          eventLocation: event["location"],
          eventPrice: event["price"],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // IMAGE
          SizedBox(
            height: 300,
            width: double.infinity,
            child: event["imageBytes"] != null
                ? Image.memory(event["imageBytes"], fit: BoxFit.cover)
                : Image.network(event["image"], fit: BoxFit.cover),
          ),

          // BACK BUTTON
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // CONTENT
          Positioned(
            top: 260,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event["title"],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  Text(
                    event["location"],
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 20),

                  Text(
                    event["price"],
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 30),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () => goToPayment(context),
                    child: Center(
                      child: Text("Buy Ticket", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'stk_push_screen.dart';

class EventDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> event;

  EventDetailsScreen({required this.event});

  void goToPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StkPushScreen(
          eventName: event["title"],
          eventPrice: event["price"],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // 🔥 TOP IMAGE
          SizedBox(
            height: screenHeight * 0.45,
            width: double.infinity,
            child: event["imageBytes"] != null
                ? Image.memory(event["imageBytes"], fit: BoxFit.cover)
                : Image.network(event["image"], fit: BoxFit.cover),
          ),

          // 🔙 BACK BUTTON
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // 🎯 BOTTOM SHEET (FIXED + SCROLLABLE)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.6, // 🔥 controlled height
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView( // 🔥 prevents overflow
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event["title"],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
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
                        child: Text(
                          "Buy Ticket",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    // ✨ Optional description (makes it feel richer)
                    Text(
                      "Event Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Join us for an unforgettable experience with music, vibes, and great people. Don’t miss out!",
                      style: TextStyle(color: Colors.white60),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
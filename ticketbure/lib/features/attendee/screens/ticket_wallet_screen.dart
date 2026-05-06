import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketScreen extends StatelessWidget {
  final String eventName;

  TicketScreen({required this.eventName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Your Ticket"), backgroundColor: Colors.black),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(color: Colors.purple.withOpacity(0.5), blurRadius: 20),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Event title
              Text(
                eventName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),

              Text("Admit One", style: TextStyle(color: Colors.white70)),

              SizedBox(height: 20),

              Divider(color: Colors.white24),

              SizedBox(height: 20),

              // QR Code
              QrImageView(
                data: eventName,
                size: 200,
                backgroundColor: Colors.white,
              ),

              SizedBox(height: 20),

              Text("Scan at entrance", style: TextStyle(color: Colors.white54)),

              SizedBox(height: 10),

              Divider(color: Colors.white24),

              SizedBox(height: 10),

              // Fake ticket ID
              Text(
                "Ticket ID: TB-${DateTime.now().millisecondsSinceEpoch}",
                style: TextStyle(fontSize: 12, color: Colors.white38),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

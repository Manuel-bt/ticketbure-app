import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../organizer/screens/scanner_screen.dart';

class TicketWalletScreen extends StatelessWidget {
  final String eventName;
  final String eventLocation;
  final String eventPrice;

  const TicketWalletScreen({super.key, 
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
      appBar: AppBar(title: Text("My Ticket")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(eventName,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold)),
            Text("$eventLocation • $eventPrice"),
            SizedBox(height: 20),
            QrImageView(data: eventName, size: 200),
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
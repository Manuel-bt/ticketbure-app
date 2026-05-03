import 'package:flutter/material.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  void validateTicket(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Ticket Verified ✅"),
        content: Text("Entry Approved"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Done"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Organizer Scanner")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => validateTicket(context),
          child: Text("Scan Ticket"),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'ticket_wallet_screen.dart';

class PaymentScreen extends StatelessWidget {
  final String eventName;
  final String eventLocation;
  final String eventPrice;

  const PaymentScreen({
    super.key,
    required this.eventName,
    required this.eventLocation,
    required this.eventPrice,
  });

  void completePayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketScreen(eventName: eventName),
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

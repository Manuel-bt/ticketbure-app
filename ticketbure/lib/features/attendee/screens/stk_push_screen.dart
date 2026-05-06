import 'package:flutter/material.dart';
import 'ticket_wallet_screen.dart';

class StkPushScreen extends StatefulWidget {
  final String eventName;
  final String eventPrice;

  StkPushScreen({required this.eventName, required this.eventPrice});

  @override
  State<StkPushScreen> createState() => _StkPushScreenState();
}

class _StkPushScreenState extends State<StkPushScreen> {
  final phoneController = TextEditingController();
  bool loading = false;
  String status = "";

  void simulatePayment() async {
    if (phoneController.text.isEmpty) return;

    setState(() {
      loading = true;
      status = "Sending STK Push...";
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      status = "Waiting for PIN confirmation...";
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      status = "Payment Successful ✅";
      loading = false;
    });

    await Future.delayed(Duration(seconds: 1));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TicketScreen(eventName: widget.eventName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mobile Money Payment")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.eventName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text("Amount: ${widget.eventPrice}"),

            SizedBox(height: 30),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Enter phone number",
                hintText: "07XXXXXXXX",
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: loading ? null : simulatePayment,
              child: Text("Pay Now"),
            ),

            SizedBox(height: 30),

            if (status.isNotEmpty)
              Text(status, style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}

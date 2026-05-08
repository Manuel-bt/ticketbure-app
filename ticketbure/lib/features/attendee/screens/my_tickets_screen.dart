import 'package:flutter/material.dart';
import '../../../core/data/ticket_store.dart';
import 'ticket_wallet_screen.dart';

class MyTicketsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("My Tickets"),
        backgroundColor: Colors.black,
      ),
      body: TicketStore.tickets.isEmpty
          ? Center(
              child: Text(
                "No tickets yet",
                style: TextStyle(color: Colors.white54),
              ),
            )
          : ListView.builder(
              itemCount: TicketStore.tickets.length,
              itemBuilder: (context, index) {
                final ticket = TicketStore.tickets[index];

                return Card(
                  color: Colors.grey[900],
                  margin: EdgeInsets.all(12),
                  child: ListTile(
                    title: Text(
                      ticket["eventName"],
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      ticket["eventPrice"],
                      style: TextStyle(color: Colors.white70),
                    ),
                    trailing: Icon(
                      Icons.qr_code,
                      color: Colors.purple,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TicketScreen(
                            eventName: ticket["eventName"],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
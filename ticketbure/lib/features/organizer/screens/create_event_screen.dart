import 'package:flutter/material.dart';

class CreateEventScreen extends StatefulWidget {
  final Function(Map<String, String>) onCreate;

  CreateEventScreen({required this.onCreate});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final priceController = TextEditingController();

  void submit() {
    final event = {
      "title": titleController.text,
      "location": locationController.text,
      "price": priceController.text,
    };

    widget.onCreate(event);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Event")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Event Title"),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: "Location"),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: "Price"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submit,
              child: Text("Create Event"),
            )
          ],
        ),
      ),
    );
  }
}
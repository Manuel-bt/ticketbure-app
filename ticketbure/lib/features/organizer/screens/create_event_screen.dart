import 'package:flutter/material.dart';
import 'map_picker_screen.dart';

class CreateEventScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onCreate;

  CreateEventScreen({required this.onCreate});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final priceController = TextEditingController();

  double? lat;
  double? lng;

  void pickLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MapPickerScreen()),
    );

    if (result != null) {
      setState(() {
        lat = result.latitude;
        lng = result.longitude;
      });
    }
  }

  void submit() {
    if (lat == null || lng == null) return;

    final event = {
      "title": titleController.text,
      "location": locationController.text,
      "price": priceController.text,
      "lat": lat,
      "lng": lng,
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
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: pickLocation,
              child: Text(lat == null
                  ? "Pick Location on Map"
                  : "Location Selected ✅"),
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
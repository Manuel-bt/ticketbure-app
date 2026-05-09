import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'map_picker_screen.dart';
import '../../../core/services/firestore_service.dart';

class CreateEventScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onCreate;

  const CreateEventScreen({super.key, required this.onCreate});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final priceController = TextEditingController();
  final firestoreService = FirestoreService();

  double? lat;
  double? lng;

  Uint8List? imageBytes;

  final picker = ImagePicker();

  Future<void> pickImage() async {
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      final bytes = await file.readAsBytes();
      setState(() {
        imageBytes = bytes;
      });
    }
  }

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

void submit() async {
  if (lat == null || lng == null || imageBytes == null) return;

  final event = {
    "title": titleController.text,
    "location": locationController.text,
    "price": priceController.text,
    "lat": lat,
    "lng": lng,
    "image":
        "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
    "createdAt": Timestamp.now(),
  };

  await firestoreService.addEvent(event);

  Navigator.pop(context);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Event")),
      body: SingleChildScrollView(
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

            SizedBox(height: 15),

            ElevatedButton(
              onPressed: pickImage,
              child: Text(
                imageBytes == null ? "Upload Event Image" : "Image Selected ✅",
              ),
            ),

            if (imageBytes != null)
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Image.memory(imageBytes!, height: 120),
              ),

            SizedBox(height: 15),

            ElevatedButton(
              onPressed: pickLocation,
              child: Text(
                lat == null ? "Pick Location on Map" : "Location Selected ✅",
              ),
            ),

            SizedBox(height: 25),

            ElevatedButton(onPressed: submit, child: Text("Create Event")),
          ],
        ),
      ),
    );
  }
}

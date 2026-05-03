import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPickerScreen extends StatefulWidget {
  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Location")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-6.7924, 39.2083),
              zoom: 13,
            ),
            onTap: (pos) {
              setState(() {
                selectedLocation = pos;
              });
            },
            markers: selectedLocation == null
                ? {}
                : {
                    Marker(
                      markerId: MarkerId("selected"),
                      position: selectedLocation!,
                    )
                  },
          ),
          if (selectedLocation != null)
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, selectedLocation);
                },
                child: Text("Confirm Location"),
              ),
            )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'features/attendee/screens/home_map_screen.dart';

void main() {
  runApp(TicketBureApp());
}

class TicketBureApp extends StatelessWidget {
  const TicketBureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TicketBure',
      theme: ThemeData.dark(),
      home: HomeMapScreen(),
    );
  }
}
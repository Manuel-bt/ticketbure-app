import 'package:flutter/material.dart';
import 'core/navigation/main_navigation.dart';

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
      home: MainNavigation(onCreate: (event) {}),
    );
  }
}

import 'package:flutter/material.dart';

import '../../features/attendee/screens/home_map_screen.dart';
import '../../features/attendee/screens/my_tickets_screen.dart';
import '../../features/organizer/screens/create_event_screen.dart';

class MainNavigation extends StatefulWidget {
  final Function(Map<String, dynamic>) onCreate;

  MainNavigation({required this.onCreate});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeMapScreen(),
      MyTicketsScreen(),
      //  CreateEventScreen(onCreate: widget.onCreate),
      Center(child: Text("Organizer Panel Soon")),
    ];

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.white54,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Explore"),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num),
            label: "Tickets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: "Create",
          ),
        ],
      ),
    );
  }
}

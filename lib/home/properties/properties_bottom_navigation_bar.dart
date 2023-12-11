import 'package:flutter/material.dart';

class PropertiesBottomNavigationBar extends StatelessWidget {
  const PropertiesBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blue, // Customize the background color
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        currentIndex: 2, // Assuming "Home" is the default selected item
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Support',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Others',
          ),
        ],
        onTap: (index) {
          // Handle navigation to different screens based on the selected index
          // You can use Navigator or any navigation logic here
        },
      ),
    );
  }
}

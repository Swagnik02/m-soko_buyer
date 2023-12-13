import 'package:flutter/material.dart';
import 'package:m_soko/home/products/widgets/products_bottom_navigation_bar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: const SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage(
                    'assets/profile_image.jpg'), // Replace with your image asset
              ),
              SizedBox(height: 20.0),
              Text(
                'John Doe', // Replace with the user's name
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'john.doe@example.com', // Replace with the user's email
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ProductsBottomNavigationBar(
        currentIndex: 0,
      ),
    );
  }
}

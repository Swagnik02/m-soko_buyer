import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.notifications_active_outlined),
                title: Text('Notifications'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

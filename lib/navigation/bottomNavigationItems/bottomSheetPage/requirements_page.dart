import 'package:flutter/material.dart';

class RequirementsPage extends StatelessWidget {
  const RequirementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.notifications_active_outlined),
                title: const Text('Notifications'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Go to Chat List'),
        ),
      ),
    );
  }
}

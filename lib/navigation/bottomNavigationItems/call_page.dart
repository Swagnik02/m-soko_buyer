import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calling'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Press Me'),
        ),
      ),
    );
  }
}

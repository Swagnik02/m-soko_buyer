import 'package:flutter/material.dart';
import 'package:m_soko/home/home_screen.dart';

class CallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calling'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // navBarIndex = 2;
            print('Button pressed!');
          },
          child: Text('Press Me'),
        ),
      ),
    );
  }
}

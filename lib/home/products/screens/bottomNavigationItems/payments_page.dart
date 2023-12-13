import 'package:flutter/material.dart';
import 'package:m_soko/home/home_screen.dart';

class PaymentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payments Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // _navBarIndex = 2;
            print('Button pressed!');
          },
          child: Text('Press Me'),
        ),
      ),
    );
  }
}

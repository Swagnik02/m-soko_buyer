import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset('assets/auth_header.png'),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 50, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Welcome to\nSokoni!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 35,
                  height: 8,
                  decoration: BoxDecoration(
                    color: ColorConstants.orange500,
                    borderRadius: BorderRadius.circular(30),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

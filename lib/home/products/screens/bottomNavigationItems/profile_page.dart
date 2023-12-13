import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:m_soko/authentication/auth_services/auth_service.dart';
import 'package:m_soko/common/colors.dart';

class ProfilePage extends StatelessWidget {
  String get userId => AuthService.firebase().currentUser!.id;
  String get userName => AuthService.firebase().currentUser!.name;
  String get email => AuthService.firebase().currentUser!.email;

  // String get mobile => AuthService.firebase().currentUser!.mobile;
  String mobile = '+27 9034566774';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            _customAppBar(),
            SizedBox(height: 10),

            // main body
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  _miniProfile(),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _aboutSection(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniProfile() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset('assets/def_profile.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello $userName!',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    mobile,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _aboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Primary Information'),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(CupertinoIcons.device_phone_portrait),
            SizedBox(width: 5),
            Text(mobile),
          ],
        ),
        SizedBox(height: 3),
        Row(
          children: [
            Icon(CupertinoIcons.mail),
            SizedBox(width: 5),
            Text(email),
          ],
        ),
      ],
    );
  }

  Widget _customAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.0),
      child: Container(
        color: ColorConstants.blue700,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/soko-logo.png',
              height: 51,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    // Handle notification icon tap
                  },
                  child: Icon(Icons.notifications, color: Colors.white),
                ),
                SizedBox(width: 16),
                InkWell(
                  onTap: () {
                    // Handle search icon tap
                  },
                  child: Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

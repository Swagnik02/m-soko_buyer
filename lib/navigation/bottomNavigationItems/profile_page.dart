import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_soko/routes/appRoutes.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // String get userId => AuthService.firebase().currentUser!.id;
  //
  // String get userName => AuthService.firebase().currentUser!.name;
  //
  // String get email => AuthService.firebase().currentUser!.email;

  // String get mobile => AuthService.firebase().currentUser!.mobile;
  String mobile = '+27 9034566774';

  String city = 'Kolkata';

  String pin = '731303';

  String state = 'West Bengal';

  String country = 'India';

  String n = '4';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // main body
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  _miniProfile(),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        _aboutSection(context),
                      ],
                    ),
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
        elevation: 2,
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
                    'Hello userName!',
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

  Widget _aboutSection(BuildContext context) {
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
            // Text(email),
          ],
        ),
        SizedBox(height: 25),
        Text('Address'),
        SizedBox(height: 10),
        Text('$city $pin'),
        SizedBox(height: 5),
        Text('$state, $country'),

        // Activity

        SizedBox(height: 25),
        Text('Activity'),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            Fluttertoast.showToast(msg: 'My Review');
          },
          child: Text('My Review'),
        ),
        SizedBox(height: 3),
        Text('$n Messages Sent'),

        // Manage Accounts
        SizedBox(height: 25),
        Text('Manage Accounts'),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            Fluttertoast.showToast(msg: 'Add Accounts');
          },
          child: Text('Add Accounts'),
        ),
        SizedBox(height: 3),
        InkWell(
          onTap: () {
            FirebaseAuth.instance
                .signOut()
                .then((value) => Get.offAllNamed(AppRoutes.loginScreen));
            Fluttertoast.showToast(msg: 'Logged Out');
          },
          child: const Text('Log Out'),
        ),
      ],
    );
  }
}

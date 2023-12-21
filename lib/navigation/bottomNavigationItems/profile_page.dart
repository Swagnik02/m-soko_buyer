import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/routes/app_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int n = 4;
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
                  const SizedBox(height: 16),
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
                    'Hello ${Users.userName}!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${Users.mobile}',
                    style: const TextStyle(
                      fontSize: 16,
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
        const Text('Primary Information'),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(CupertinoIcons.device_phone_portrait),
            const SizedBox(width: 5),
            Text(Users.mobile.toString()),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Icon(CupertinoIcons.mail),
            SizedBox(width: 5),
            Text(Users.email ?? ''),
          ],
        ),
        const SizedBox(height: 25),
        const Text('Address'),
        const SizedBox(height: 10),
        Text('${Users.city} ${Users.pin}'),
        const SizedBox(height: 5),
        Text('${Users.state}, ${Users.country}'),

        // Activity

        const SizedBox(height: 25),
        const Text('Activity'),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            Fluttertoast.showToast(msg: 'My Review');
          },
          child: const Text('My Review'),
        ),
        const SizedBox(height: 3),
        Text('$n Messages Sent'),

        // Manage Accounts
        const SizedBox(height: 25),
        const Text('Manage Accounts'),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            Fluttertoast.showToast(msg: 'Add Accounts');
          },
          child: const Text('Add Accounts'),
        ),
        const SizedBox(height: 3),
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

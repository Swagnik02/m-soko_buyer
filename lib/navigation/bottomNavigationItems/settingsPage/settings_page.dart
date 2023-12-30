import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/routes/app_routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
              ListTile(
                leading: Icon(Icons.receipt_long_rounded),
                title: Text('Terms, Policies and Licenses'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.question_answer_outlined),
                title: Text('Browse FAQs'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.person_outline_rounded),
                title: Text('Account'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.feedback_outlined),
                title: Text('Feedback'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.language_rounded),
                title: Text('Choose Language'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('About Us'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.help_outline),
                title: Text('Help & Support'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout_outlined),
                title: Text('Logout'),
                onTap: () {
                  FirebaseAuth.instance
                      .signOut()
                      .then((value) => Get.offAllNamed(AppRoutes.loginScreen));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

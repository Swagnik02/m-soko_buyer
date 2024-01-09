import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/navigation/bottomNavigationItems/settingsPage/selected_settings_page.dart';
import 'package:m_soko/navigation/page_transitions.dart';
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
                leading: const Icon(Icons.notifications_active_outlined),
                title: const Text('Notifications'),
                onTap: () => _redirectToSelectedPage(context, 'Notifications'),
              ),
              ListTile(
                leading: const Icon(Icons.receipt_long_rounded),
                title: const Text('Terms, Policies and Licenses'),
                onTap: () => _redirectToSelectedPage(
                    context, 'Terms, Policies and Licenses'),
              ),
              ListTile(
                leading: const Icon(Icons.question_answer_outlined),
                title: const Text('Browse FAQs'),
                onTap: () => _redirectToSelectedPage(context, 'Browse FAQs'),
              ),
              ListTile(
                leading: const Icon(Icons.person_outline_rounded),
                title: const Text('Account'),
                onTap: () => _redirectToSelectedPage(context, 'Account'),
              ),
              ListTile(
                leading: const Icon(Icons.feedback_outlined),
                title: const Text('Feedback'),
                onTap: () => _redirectToSelectedPage(context, 'Feedback'),
              ),
              ListTile(
                leading: const Icon(Icons.language_rounded),
                title: const Text('Choose Language'),
                onTap: () =>
                    _redirectToSelectedPage(context, 'Choose Language'),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About Us'),
                onTap: () => _redirectToSelectedPage(context, 'About Us'),
              ),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('Help & Support'),
                onTap: () => _redirectToSelectedPage(context, 'Help & Support'),
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text('Logout'),
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

  void _redirectToSelectedPage(BuildContext context, String destinationPage) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return SelectedSettingsPage(
            destinationPage: destinationPage,
          );
        },
        transitionsBuilder: customTransition(const Offset(0, 0)),
      ),
    );
  }
}

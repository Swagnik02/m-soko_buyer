import 'package:flutter/material.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/bookmarks_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/feedback_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/help_support_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/profilePage/profile_page.dart';

class SelectedSettingsPage extends StatefulWidget {
  final String destinationPage;
  const SelectedSettingsPage({super.key, required this.destinationPage});

  @override
  State<SelectedSettingsPage> createState() => _SelectedSettingsPageState();
}

class _SelectedSettingsPageState extends State<SelectedSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // actions: [Icon(Icons.search)],
        title: Text(
          widget.destinationPage,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: _mainBody(widget.destinationPage),
      ),
    );
  }

  Widget _mainBody(String destinationPage) {
    switch (destinationPage) {
      // case 'Notifications':
      //   return ProfilePage();
      // case 'Terms, Policies and Licenses':
      //   return ProfilePage();
      // case 'Browse FAQs':
      //   return ProfilePage();
      case 'Save':
        return const BookmarksPage();
      case 'Account':
        return const ProfilePage();
      case 'Feedback':
        return const FeedbackPage();
      // case 'Choose Language':
      //   return ProfilePage();
      case 'Help & Support':
        return const HelpSupportPage();

      default:
        return const ProfilePage();
    }
  }
}

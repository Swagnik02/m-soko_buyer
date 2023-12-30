import 'package:flutter/material.dart';
import 'package:m_soko/home/products/screens/all_categories_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/orders_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/profilePage/profile_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/settingsPage/settings_page.dart';

class BottomSheetSelectedItemPage extends StatefulWidget {
  final String destinationPage;
  const BottomSheetSelectedItemPage({super.key, required this.destinationPage});

  @override
  State<BottomSheetSelectedItemPage> createState() =>
      _BottomSheetSelectedItemPageState();
}

class _BottomSheetSelectedItemPageState
    extends State<BottomSheetSelectedItemPage> {
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
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: _mainBody(widget.destinationPage),
      ),
    );
  }

  Widget _mainBody(String destinationPage) {
    switch (destinationPage) {
      case 'Orders':
        return OrdersPage();
      case 'Requirements':
        return ProfilePage();
      case 'Save':
        return ProfilePage();
      case 'Categories':
        return const AllCategoriesPage();
      case 'Profile':
        return const ProfilePage();
      case 'Address':
        return ProfilePage();
      case 'Payment':
        return ProfilePage();
      case 'About':
        return ProfilePage();
      case 'Feedback':
        return ProfilePage();
      case 'Help/Support':
        return ProfilePage();
      case 'Settings':
        return SettingsPage();

      default:
        return ProfilePage();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:m_soko/home/products/screens/all_categories_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/profilePage/profile_page.dart';

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
      body: SafeArea(
        child: _mainBody(widget.destinationPage),
      ),
    );
  }

  Widget _mainBody(String destinationPage) {
    switch (destinationPage) {
      case 'Home':
        return ProfilePage();
      case 'Orders':
        return ProfilePage();
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
        return ProfilePage();

      default:
        return ProfilePage();
    }
  }
}

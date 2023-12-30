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
      case 'Profile':
        return ProfilePage();
      case 'Categories':
        return AllCategoriesPage();
      default:
        return ProfilePage();
    }
  }
}



              // 'Home',

              // 'Orders',

              // 'Requirements',

              // 'Save',

              // 'Categories',
       
              // 'Profile',
              // 'Address',
              // 'Payment',
              // 'About',
   
              // 'Feedback',
  
              // 'Help/Support',
           
              // 'Settings',
          
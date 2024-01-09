import 'package:flutter/material.dart';
import 'package:m_soko/home/products/screens/all_categories_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/about_us_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/address/address_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/bookmarks_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/feedback_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/help_support_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/orders_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/requirements_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/paymentsPage/payments_page.dart';
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
      case 'Orders':
        return const OrdersPage();
      case 'Requirements':
        return const RequirementsPage();
      case 'Save':
        return const BookmarksPage();
      case 'Categories':
        return const AllCategoriesPage();
      case 'Profile':
        return const ProfilePage();
      case 'Address':
        return const AddressPage();
      case 'Payment':
        return PaymentsPage();
      case 'About':
        return const AboutUsPage();
      case 'Feedback':
        return const FeedbackPage();
      case 'Help/Support':
        return const HelpSupportPage();
      case 'Settings':
        return const SettingsPage();

      default:
        return const SettingsPage();
    }
  }
}

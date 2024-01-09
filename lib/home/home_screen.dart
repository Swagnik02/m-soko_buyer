import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/home_screen_controller.dart';
import 'package:m_soko/navigation/bottomNavigationItems/call_page/call_page_screen.dart';
import 'package:m_soko/navigation/bottomNavigationItems/propertyMessageScreen/property_message_list.dart';
import 'package:m_soko/navigation/bottomNavigationItems/chatScreen/chat_list_screen.dart';
import 'package:m_soko/navigation/bottomNavigationItems/property_saved_screen.dart';
import 'package:m_soko/navigation/bottomNavigationItems/settingsPage/settings_page.dart';
import 'package:m_soko/navigation/bottom_nav_bar.dart';
import 'package:m_soko/navigation/bottomNavigationItems/paymentsPage/payments_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/profilePage/profile_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/support_page.dart';
import 'package:m_soko/home/products/screens/products_page.dart';
import 'package:m_soko/home/properties/screens/properties_screen.dart';
import 'package:m_soko/home/services/services_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeScreenController>(
        builder: (_) => SafeArea(
          child: controller.navBarIndex == 2 ? _home() : _selectedNavHome(),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // conditions set to open pages
  //according to the value of indexes
  //controller.navBarIndex = index of bottomNavBar
  //controller.topBarIndex = index of TopBar

  Widget _selectedNavHome() {
    return Column(
      children: [
        PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Container(
              color: _getTopBarColor(controller.topBarIndex),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _customAppBar(controller.topBarIndex),
            )),
        Expanded(
          child: _selectedNavPage(),
        ),
      ],
    );
  }

  Widget _customAppBar(int topBarIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          topBarIndex == 2
              ? 'assets/app_bar_logo_black.png'
              : 'assets/soko-logo.png',
          height: 51,
        ),
        InkWell(
          onTap: () {
            // Handle notification icon tap
          },
          child: const Icon(Icons.notifications, color: Colors.white),
        ),
      ],
    );
  }

  Widget _selectedNavPage() {
    log(controller.navBarIndex.toString());
    log(controller.topBarIndex.toString());
    switch (controller.navBarIndex) {
      case 0:
        return const ProfilePage();
      case 1:
        switch (controller.topBarIndex) {
          case 0: // Products Section
            return const ChatListScreen();
          case 1: // Property Section
            return const CallsPropertyScreen();
          case 2: // Services Section
            return const SupportPage();
          default:
            return Container();
        }
      case 2:
        return _home();
      case 3:
        switch (controller.topBarIndex) {
          case 0: // Products Section
            return const PaymentsPage();
          case 1: // Property Section
            return const PropertySavedScreen();
          case 2: // Services Section
            return const PaymentsPage();

          default:
            return Container();
        }
      case 4:
        switch (controller.topBarIndex) {
          case 1: // Property Section
            return const PropertyMessageList();
          case 2: // Services Section
            return _home();

          default:
            return const SettingsPage();
        }
      default:
        return Container();
    }
  }

  Widget _home() {
    return Column(
      children: [
        PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Container(
              color: _getTopBarColor(controller.topBarIndex),
              // padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: controller.navBarIndex == 2 ? _topNavBar() : Container(),
            )),
        Expanded(
          child: _buildBody(),
        ),
      ],
    );
  }

  Widget _topNavBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTopBarButton("Products", 0),
        _buildTopBarButton("Properties", 1),
        _buildTopBarButton("Services", 2),
        // _buildTopBarButton("logout", 3),
      ],
    );
  }

  Color _getTopBarColor(int index) {
    switch (index) {
      case 0:
        return ColorConstants.blue700;
      case 1:
        return ColorConstants.green800;
      case 2:
        return ColorConstants.orange500;
      default:
        return ColorConstants.blue700;
    }
  }

  Widget _buildTopBarButton(String title, int index) {
    return GestureDetector(
      onTap: () => controller.updateTopBarIndex(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: controller.topBarIndex == index
                  ? ColorConstants.yellow400
                  : Colors.transparent,
              width: 6.0,
            ),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (controller.topBarIndex) {
      case 0:
        return const ProductsScreen();
      case 1:
        return PropertiesScreen();
      case 2:
        return ServicesScreen();
      // case 3:
      //   return LogoutScreen();

      default:
        return Container();
    }
  }

  // added onIndexChanged as argument changed
  Widget _buildBottomNavigationBar() {
    switch (controller.topBarIndex) {
      case 0:
        return BottomNavBar(
          onIndexChanged: (int changedIndex) =>
              controller.updateNavBarIndex(changedIndex),
          topBarIndex: controller.topBarIndex,
        );
      case 1:
        return BottomNavBar(
          onIndexChanged: (int changedIndex) =>
              controller.updateNavBarIndex(changedIndex),
          circleIndicatorColor: ColorConstants.green800,
          iconIndex1: CupertinoIcons.phone,
          iconIndex3: Icons.bookmark_border,
          iconIndex4: CupertinoIcons.text_bubble,
          topBarIndex: controller.topBarIndex,
        );
      case 2:
        return BottomNavBar(
          onIndexChanged: (int changedIndex) =>
              controller.updateNavBarIndex(changedIndex),
          circleIndicatorColor: ColorConstants.orange500,
          topBarIndex: controller.topBarIndex,
        );
      default:
        // return Container();
        return BottomNavBar(
          onIndexChanged: (int changedIndex) =>
              controller.updateNavBarIndex(changedIndex),
          topBarIndex: controller.topBarIndex,
        );
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/authentication/auth_services/auth_service.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/navigation/bottom_nav_bar.dart';
import 'package:m_soko/home/products/screens/bottomNavigationItems/call_page.dart';
import 'package:m_soko/home/products/screens/bottomNavigationItems/payments_page.dart';
import 'package:m_soko/home/products/screens/bottomNavigationItems/profile_page.dart';
import 'package:m_soko/home/products/screens/bottomNavigationItems/support_page.dart';
import 'package:m_soko/home/products/screens/products_page.dart';
import 'package:m_soko/home/properties/properties_screen.dart';
import 'package:m_soko/home/services/services_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String get userId => AuthService.firebase().currentUser!.id;
  String get userName => AuthService.firebase().currentUser!.name;

  int navBarIndex = 2;
  int _topBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: navBarIndex == 2 ? _home() : _slectedNavHome(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // conditions set to open pages
  //according to the value of indexes
  //navBarIndex = index of bottomNavBar
  //_topBarIndex = index of TopBar

  Widget _slectedNavHome() {
    return Column(
      children: [
        PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: Container(
              color: _getTopBarColor(_topBarIndex),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: _customAppBar(_topBarIndex),
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
        Row(
          children: [
            InkWell(
              onTap: () {
                // Handle notification icon tap
              },
              child: Icon(Icons.notifications, color: Colors.white),
            ),
            SizedBox(width: 16),
            InkWell(
              onTap: () {
                // Handle search icon tap
              },
              child: Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _selectedNavPage() {
    switch (navBarIndex) {
      case 0:
        return ProfilePage();
      case 1:
        switch (_topBarIndex) {
          case 0: // Products Section
            return SupportPage();
          case 1: // Property Section
            return CallPage();
          case 2: // Services Section
            return SupportPage();
          default:
            return Container();
        }
      case 2:
        return _home();
      case 3:
        return PaymentsPage();
      default:
        return Container();
    }
  }

  Widget _home() {
    return Column(
      children: [
        PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: Container(
              color: _getTopBarColor(_topBarIndex),
              // padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: navBarIndex == 2 ? _TopNavBar() : Container(),
            )),
        Expanded(
          child: _buildBody(),
        ),
      ],
    );
  }

  Widget _TopNavBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTopBarButton("Products", 0),
        _buildTopBarButton("Properties", 1),
        _buildTopBarButton("Services", 2),
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
      onTap: () {
        setState(() {
          _topBarIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _topBarIndex == index
                  ? ColorConstants.yellow400
                  : Colors.transparent,
              width: 6.0,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_topBarIndex) {
      case 0:
        return ProductsScreen();
      case 1:
        return PropertiesScreen();
      case 2:
        return ServicesScreen();

      default:
        return Container();
    }
  }

  // added onIndexChanged as argument changed
  Widget _buildBottomNavigationBar() {
    switch (_topBarIndex) {
      case 0:
        return BottomNavBar(
          onIndexChanged: (int changedIndex) {
            setState(() {
              navBarIndex = changedIndex;
            });
          },
        );
      case 1:
        return BottomNavBar(
          onIndexChanged: (int changedIndex) {
            setState(() {
              navBarIndex = changedIndex;
            });
          },
          circleIndicatorColor: ColorConstants.green800,
          iconIndex1: CupertinoIcons.phone,
          iconIndex3: Icons.bookmark_border,
          iconIndex4: CupertinoIcons.text_bubble,
        );
      case 2:
        return BottomNavBar(
          onIndexChanged: (int changedIndex) {
            setState(() {
              navBarIndex = changedIndex;
            });
          },
          circleIndicatorColor: ColorConstants.orange500,
        );
      default:
        // return Container();
        return BottomNavBar(
          onIndexChanged: (int changedIndex) {
            setState(() {
              navBarIndex = changedIndex;
            });
          },
        );
    }
  }
}

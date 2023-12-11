import 'package:flutter/material.dart';
import 'package:m_soko/authentication/auth_services/auth_service.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/products_bottom_navigation_bar.dart';
import 'package:m_soko/home/products/products_page.dart';
import 'package:m_soko/home/properties/properties_bottom_navigation_bar.dart';
import 'package:m_soko/home/properties/properties_screen.dart';
import 'package:m_soko/home/services/services_bottom_navigation_bar.dart';
import 'package:m_soko/home/services/services_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String get userId => AuthService.firebase().currentUser!.id;
  String get userName => AuthService.firebase().currentUser!.name;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: Container(
                color: ColorConstants.blue700,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTopBarButton("Products", 0),
                    _buildTopBarButton("Properties", 1),
                    _buildTopBarButton("Services", 2),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTopBarButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _currentIndex == index ? Colors.white : Colors.transparent,
              width: 2.0,
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
    switch (_currentIndex) {
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

  Widget _buildBottomNavigationBar() {
    switch (_currentIndex) {
      case 0:
        return ProductsBottomNavigationBar();
      case 1:
        return PropertiesBottomNavigationBar();
      case 2:
        return ServicesBottomNavigationBar();
      default:
        return Container();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:m_soko/authentication/auth_services/auth_service.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/logout.dart';
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
                  color: _getTopBarColor(_currentIndex),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTopBarButton("Products", 0),
                      _buildTopBarButton("Properties", 1),
                      _buildTopBarButton("Services", 2),
                      _buildTopBarButton("out", 3),
                    ],
                  ),
                )),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
          _currentIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _currentIndex == index
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
    switch (_currentIndex) {
      case 0:
        return Theme(
          data: ThemeData(
            primaryColor: ColorConstants.blue700,
            hintColor: ColorConstants.yellow500,
          ),
          child: ProductsScreen(),
        );
      case 1:
        return Theme(
          data: ThemeData(
            primaryColor: ColorConstants.green700,
            hintColor: ColorConstants.yellow500,
          ),
          child: PropertiesScreen(),
        );
      case 2:
        return Theme(
          data: ThemeData(
            primaryColor:
                ColorConstants.orange700, // Change to your desired color
            hintColor: ColorConstants.yellow500,
          ),
          child: ServicesScreen(),
        );
      case 3:
        return LogoutScreen();
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
        // return Container();
        return ProductsBottomNavigationBar();
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';

class ProductsBottomNavigationBar extends StatefulWidget {
  const ProductsBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _ProductsBottomNavigationBarState createState() =>
      _ProductsBottomNavigationBarState();
}

class _ProductsBottomNavigationBarState
    extends State<ProductsBottomNavigationBar> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   color: Colors.blue,
      // ),
      child: Stack(
        children: [
          BottomNavigationBar(
            // backgroundColor: Colors.transparent,
            selectedItemColor: Colors.black,
            unselectedItemColor: ColorConstants.blue900,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            iconSize: 35.0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_rounded),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.text_bubble),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_rounded),
                label: '',
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              // Handle navigation to different screens based on the selected index
              // You can use Navigator or any navigation logic here
            },
          ),
          _buildRedCircleIndicator(),
          _buildSelectedLabelIndicator(),
        ],
      ),
    );
  }

  Widget _buildSelectedLabelIndicator() {
    double itemWidth = MediaQuery.of(context).size.width / 8;
    double indicatorPosition =
        _currentIndex * MediaQuery.of(context).size.width / 5 + itemWidth / 3;

    return Positioned(
      bottom: 2,
      left: indicatorPosition,
      child: Container(
        width: itemWidth,
        height: 6.0,
        color: ColorConstants.yellow400,
      ),
    );
  }

  Widget _buildRedCircleIndicator() {
    double itemWidth = MediaQuery.of(context).size.width / 5;
    double indicatorPosition =
        _currentIndex * MediaQuery.of(context).size.width / 5 + itemWidth / 5.5;

    return Positioned(
      bottom: 20,
      left: indicatorPosition,
      child: Container(
        width: 50.0,
        height: 50.0,
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(50, 8, 32, 94),
        ),
      ),
    );
  }
}

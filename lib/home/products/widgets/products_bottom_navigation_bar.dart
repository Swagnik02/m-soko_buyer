import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/screens/bottomNavigationItems/profile_page.dart';
import 'package:m_soko/main.dart';
import 'package:m_soko/navigation/page_transitions.dart';

class ProductsBottomNavigationBar extends StatefulWidget {
  final int currentIndex;

  const ProductsBottomNavigationBar({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  _ProductsBottomNavigationBarState createState() =>
      _ProductsBottomNavigationBarState();
}

class _ProductsBottomNavigationBarState
    extends State<ProductsBottomNavigationBar> {
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          _buildCircleIndicator(),
          _bottomNavigationBar(),
          _buildSelectedLabelIndicator(),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      iconSize: 35.0,
      elevation: 0,
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
        if (index == 0) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ProfilePage(),
              transitionsBuilder: customTransition(const Offset(0.0, 0.0)),
            ),
          );
        }
        // if (index == 2) {
        //   Navigator.pop(context);
        // }
      },
    );
  }

  Widget _buildSelectedLabelIndicator() {
    double itemWidth = MediaQuery.of(context).size.width / 8.5;
    double indicatorPosition =
        _currentIndex * MediaQuery.of(context).size.width / 5 + itemWidth / 2.8;

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

  Widget _buildCircleIndicator() {
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
          color: ColorConstants.blue700,
        ),
      ),
    );
  }
}

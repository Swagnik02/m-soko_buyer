import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';

class ProductsBottomNavigationBar extends StatefulWidget {
  final Function(int prodNavBarIndex) onIndexChanged;

  const ProductsBottomNavigationBar({Key? key, required this.onIndexChanged})
      : super(key: key);

  @override
  _ProductsBottomNavigationBarState createState() =>
      _ProductsBottomNavigationBarState();
}

class _ProductsBottomNavigationBarState
    extends State<ProductsBottomNavigationBar> {
  int prodNavBarIndex = 2;

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
      currentIndex: prodNavBarIndex,
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
          prodNavBarIndex = index;
        });
        // Call the callback to notify the parent (HomeScreen) about the indices change
        widget.onIndexChanged(prodNavBarIndex);
      },
    );
  }

  Widget _buildSelectedLabelIndicator() {
    double itemWidth = MediaQuery.of(context).size.width / 8.5;
    double indicatorPosition =
        prodNavBarIndex * MediaQuery.of(context).size.width / 5 +
            itemWidth / 2.8;

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
        prodNavBarIndex * MediaQuery.of(context).size.width / 5 +
            itemWidth / 5.5;

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

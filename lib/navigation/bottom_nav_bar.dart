import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/bottom_sheet_menu.dart';
import 'package:m_soko/navigation/bottomNavigationItems/profilePage/profile_controller.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int mainNavBarIndex) onIndexChanged;
  final IconData iconIndex0;
  final IconData iconIndex1;
  final IconData iconIndex2;
  final IconData iconIndex3;
  final IconData iconIndex4;
  final Color circleIndicatorColor;
  final int topBarIndex;

  const BottomNavBar({
    super.key,
    required this.onIndexChanged,
    this.iconIndex0 = Icons.person,
    this.iconIndex1 = CupertinoIcons.text_bubble,
    this.iconIndex2 = Icons.home,
    this.iconIndex3 = Icons.payment,
    this.iconIndex4 = Icons.menu,
    this.circleIndicatorColor = ColorConstants.blue700,
    required this.topBarIndex,
  });

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int mainNavBarIndex = 2;

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
      currentIndex: mainNavBarIndex,
      type: BottomNavigationBarType.fixed,
      iconSize: 35.0,
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(widget.iconIndex0),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(widget.iconIndex1),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(widget.iconIndex2),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(widget.iconIndex3),
          label: '',
        ),
        if (widget.topBarIndex == 0 || widget.topBarIndex == 2)
          BottomNavigationBarItem(
            icon: InkWell(
              child: Icon(
                widget.iconIndex4,
              ),
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  useRootNavigator: true,
                  builder: (BuildContext context) {
                    return bottomNavigaitonMenu(context);
                  },
                );
              },
            ),
            label: '',
          )
        else
          BottomNavigationBarItem(
            icon: Icon(widget.iconIndex4),
            label: '',
          ),
      ],
      onTap: (index) {
        setState(() {
          mainNavBarIndex = index;
          Get.delete<ProfileController>();
        });
        widget.onIndexChanged(mainNavBarIndex);
      },
    );
  }

  Widget _buildSelectedLabelIndicator() {
    double itemWidth = MediaQuery.of(context).size.width / 8.5;
    double indicatorPosition =
        mainNavBarIndex * MediaQuery.of(context).size.width / 5 +
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
        mainNavBarIndex * MediaQuery.of(context).size.width / 5 +
            itemWidth / 5.5;

    return Positioned(
      bottom: 20,
      left: indicatorPosition,
      child: Container(
        width: 50.0,
        height: 50.0,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.circleIndicatorColor,
        ),
      ),
    );
  }
}

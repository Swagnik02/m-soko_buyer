import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/navigation/bottomNavigationItems/profilePage/profile_page.dart';
import 'package:m_soko/navigation/page_transitions.dart';

Widget bottomNavigaitonMenu(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildRow([
            buildContainer(
              context,
              Icons.home_outlined,
              'Home',
            ),
            buildContainer(
              context,
              Icons.home_outlined,
              'Home',
            ),
          ]),
          buildRow([
            buildContainer(
              context,
              Icons.home_outlined,
              'Home',
            ),
            buildContainer(
              context,
              Icons.home_outlined,
              'Home',
            ),
          ]),
          buildRow([
            buildContainer(
              context,
              Icons.home_outlined,
              'Home',
            ),
            buildContainer(
              context,
              Icons.home_outlined,
              'Home',
            ),
          ]),
          buildRow([
            buildContainer(
              context,
              Icons.home_outlined,
              'Home',
            ),
            buildContainer(
              context,
              Icons.home_outlined,
              'Home',
            ),
          ]),
          buildRow([
            buildContainer(
              context,
              Icons.home_outlined,
              'Home',
            ),
            buildContainer(
              context,
              Icons.home_outlined,
              'Home',
            ),
          ]),
          buildRow([
            buildContainer(
              context,
              Icons.home_outlined,
              'Home',
            ),
            buildContainer(
              context,
              Icons.home_outlined,
              'Home',
            ),
          ]),
        ],
      ),
    ),
  );
}

Widget buildRow(List<Widget> children) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: children,
  );
}

Widget buildContainer(
  BuildContext context,
  IconData labelIcon,
  String labelName,
) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: InkWell(
        onTap: () {
          _navigateToProfilePage(context);
        },
        child: Container(
          // width: 180,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Row(
              children: [
                Icon(labelIcon),
                Text(labelName),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Future _navigateToProfilePage(
  BuildContext context,
) {
  return Navigator.of(context).push(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return ProfilePage();
    },
    transitionsBuilder: customTransition(const Offset(0, 0)),
  ));
}

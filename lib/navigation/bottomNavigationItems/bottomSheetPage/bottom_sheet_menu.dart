import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/bottom_sheet_selected_item_page.dart';
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
              Icons.event_note_sharp,
              'Orders',
            ),
          ]),
          buildRow([
            buildContainer(
              context,
              CupertinoIcons.text_bubble,
              'Requirements',
            ),
            buildContainer(
              context,
              Icons.bookmark_border_rounded,
              'Save',
            ),
          ]),
          buildRow([
            buildContainer(
              context,
              Icons.now_widgets_outlined,
              'Categories',
            ),
            buildContainer(
              context,
              Icons.person_outline_rounded,
              'Profile',
            ),
          ]),
          buildRow([
            buildContainer(
              context,
              Icons.location_on_outlined,
              'Address',
            ),
            buildContainer(
              context,
              Icons.payments_outlined,
              'Payment',
            ),
          ]),
          buildRow([
            buildContainer(
              context,
              Icons.info_outline,
              'About',
            ),
            buildContainer(
              context,
              Icons.feedback_outlined,
              'Feedback',
            ),
          ]),
          buildRow([
            buildContainer(
              context,
              Icons.help_outline_rounded,
              'Help/Support',
            ),
            buildContainer(
              context,
              Icons.settings_outlined,
              'Settings',
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
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return BottomSheetSelectedItemPage(
                destinationPage: labelName,
              );
            },
            transitionsBuilder: customTransition(const Offset(0, 0)),
          ));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(labelIcon),
              ),
              Text(labelName),
            ],
          ),
        ),
      ),
    ),
  );
}

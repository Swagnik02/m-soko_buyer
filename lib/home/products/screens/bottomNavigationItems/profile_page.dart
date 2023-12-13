import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _customAppBar(),
            Expanded(
              child: _profileBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileBody() {
    // Implement your profile body here
    return Container();
  }

  Widget _customAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.0),
      child: Container(
        color: ColorConstants.blue700,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/soko-logo.png',
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
        ),
      ),
    );
  }
}

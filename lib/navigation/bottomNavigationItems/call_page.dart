import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Dialling..',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: Get.height * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xffFDF5F1),
                    radius: 80,
                  ),
                  Positioned(
                    left: 14,
                    right: 14,
                    top: 14,
                    bottom: 14,
                    child: CircleAvatar(
                      backgroundColor: Color(0xffCFF4D2),
                      radius: 66,
                    ),
                  ),
                  Positioned(
                    left: 26,
                    right: 26,
                    top: 26,
                    bottom: 26,
                    child: CircleAvatar(
                      backgroundColor: Color(0xff77F169),
                      radius: 56,
                    ),
                  ),
                  Positioned(
                    left: 36,
                    right: 36,
                    top: 36,
                    bottom: 36,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/profile-pic.jpg'),
                      radius: 46,
                    ),
                  )
                ],
              ),
            ),
            const Text(
              'Jack William',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: Colors.grey, size: 18),
                Text(
                  'Sector 107, Noida',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.01),
            const Text(
              '+91789095697',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: Get.height * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIcon(iconData: Icons.mic_none_rounded, title: 'Mute'),
                _buildIcon(
                    iconData: Icons.bluetooth_outlined, title: 'Bluetooth'),
                _buildIcon(
                    iconData: Icons.phone_paused_outlined, title: 'Hold'),
              ],
            ),
            SizedBox(height: Get.height * 0.06),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIcon(
                    iconData: Icons.grid_view_outlined,
                    isTitle: false,
                    iconSize: 30),
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xffFEE2E3),
                  child: Icon(Icons.call_end, color: Colors.red, size: 40),
                ),
                _buildIcon(
                    iconData: Icons.volume_down_outlined,
                    isTitle: false,
                    iconSize: 38),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildIcon(
      {required IconData iconData,
      String? title,
      bool isTitle = true,
      double? iconSize}) {
    return Column(
      children: [
        Icon(
          iconData,
          color: Colors.grey,
          size: iconSize ?? 36,
        ),
        isTitle
            ? Text(
                title ?? '',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              )
            : Container(),
      ],
    );
  }
}

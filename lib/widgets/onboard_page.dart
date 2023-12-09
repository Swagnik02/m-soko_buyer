import 'package:flutter/material.dart';
import 'package:m_soko/authentication/login_screen.dart';
import 'package:m_soko/common/colors.dart';

class OnboardPage extends StatelessWidget {
  final PageController controller;
  final int pageIndex;
  final String imageUrl;
  final String desc1;
  final String desc2;
  final String desc3;

  const OnboardPage({
    super.key,
    required this.controller,
    required this.pageIndex,
    required this.imageUrl,
    required this.desc1,
    required this.desc2,
    required this.desc3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Image.asset(imageUrl),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              _buildListItem(desc1),
              _buildListItem(desc2),
              _buildListItem(desc3),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  pageIndex == 2
                      ? Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        }))
                      : controller.animateToPage(pageIndex + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                },
                child: Container(
                  width: 150,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorConstants.orange500,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        pageIndex == 2 ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildListItem(String desc) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              desc,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.white,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

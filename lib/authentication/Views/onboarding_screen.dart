import 'package:flutter/material.dart';
import 'package:m_soko/widgets/onboard_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final String demoText =
      'Lorem ipsum dolor sit amet consectetur adipisicing elit.';
  final PageController controller = PageController(initialPage: 0);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08215E),
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: controller,
            onPageChanged: (value) {
              setState(() {
                pageIndex = value;
              });
            },
            children: [
              OnboardPage(
                controller: controller,
                pageIndex: 0,
                imageUrl: 'assets/auth/onboard1.png',
                desc1: demoText,
                desc2: demoText,
                desc3: demoText,
              ),
              OnboardPage(
                controller: controller,
                pageIndex: 1,
                imageUrl: 'assets/auth/onboard2.png',
                desc1: demoText,
                desc2: demoText,
                desc3: demoText,
              ),
              OnboardPage(
                controller: controller,
                pageIndex: 2,
                imageUrl: 'assets/auth/onboard3.png',
                desc1: demoText,
                desc2: demoText,
                desc3: demoText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

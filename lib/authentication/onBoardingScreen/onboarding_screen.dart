import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/authentication/onBoardingScreen/on_boarding_controller.dart';
import 'package:m_soko/authentication/onBoardingScreen/onboard_page_widget.dart';
import 'package:m_soko/common/utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF08215E),
        body: GetBuilder<OnBoardingController>(
          builder: (_) {
            return Stack(
              alignment: Alignment.center,
              children: [
                PageView(
                  controller: controller.pageController,
                  onPageChanged: (value) => controller.onPageChange(value),
                  children: [
                    OnboardPage(
                      controller: controller.pageController,
                      pageIndex: controller.currentIndex,
                      imageUrl: 'assets/auth/onboard1.png',
                      desc1: GlobalUtil.demoText,
                      desc2: GlobalUtil.demoText,
                      desc3: GlobalUtil.demoText,
                    ),
                    OnboardPage(
                      controller: controller.pageController,
                      pageIndex: controller.currentIndex,
                      imageUrl: 'assets/auth/onboard2.png',
                      desc1: GlobalUtil.demoText,
                      desc2: GlobalUtil.demoText,
                      desc3: GlobalUtil.demoText,
                    ),
                    OnboardPage(
                      controller: controller.pageController,
                      pageIndex: controller.currentIndex,
                      imageUrl: 'assets/auth/onboard3.png',
                      desc1: GlobalUtil.demoText,
                      desc2: GlobalUtil.demoText,
                      desc3: GlobalUtil.demoText,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

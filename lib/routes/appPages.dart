import 'package:get/get.dart';
import 'package:m_soko/authentication/onBoardingScreen/onboarding_screen.dart';
import 'package:m_soko/authentication/authHome.dart';
import 'package:m_soko/routes/appRoutes.dart';

class AppPages {
  static List<GetPage> appPages = [
    GetPage(name: AppRoutes.authHome, page: () => AuthHome()),
    GetPage(name: AppRoutes.onBoardingScreen, page: () => OnboardingScreen()),
  ];
}

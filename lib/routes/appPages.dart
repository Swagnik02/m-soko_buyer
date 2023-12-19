import 'package:get/get.dart';
import 'package:m_soko/authentication/Views/loginView/login_view.dart';
import 'package:m_soko/authentication/Views/registerView/register_view.dart';
import 'package:m_soko/authentication/onBoardingScreen/onboarding_screen.dart';
import 'package:m_soko/authentication/authHome.dart';
import 'package:m_soko/home/home_screen.dart';
import 'package:m_soko/home/properties/screens/propertiesDetailScreen.dart';
import 'package:m_soko/home/properties/screens/properySeeAllScreen.dart';
import 'package:m_soko/routes/appRoutes.dart';

class AppPages {
  static List<GetPage> appPages = [
    GetPage(name: AppRoutes.authHome, page: () => AuthHome()),
    GetPage(name: AppRoutes.homeScreen, page: () => HomeScreen()),
    GetPage(name: AppRoutes.onBoardingScreen, page: () => OnboardingScreen()),
    GetPage(name: AppRoutes.loginScreen, page: () => LoginView()),
    GetPage(name: AppRoutes.registerScreen, page: () => RegisterView()),
    GetPage(
        name: AppRoutes.propertiesDetailScreen,
        page: () => PropertiesDetailScreen()),
    GetPage(
        name: AppRoutes.propertiesSeeAllScreen,
        page: () => PropertySeeAllScreen()),
  ];
}

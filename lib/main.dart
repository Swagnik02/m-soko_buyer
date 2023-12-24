import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/firebase_options.dart';
import 'package:m_soko/models/user_model.dart';
import 'package:m_soko/routes/app_pages.dart';
import 'package:m_soko/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Retrieve user data from local storage
  await UserDataService().retrieveUserDataLocally();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  GlobalUtil.isViewed = prefs.getInt(GlobalUtil.onBordingToken);

  // Run the app
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // supportedLocales: AppLocalizations.supportedLocales,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: ColorConstants.blue700,
          appBarTheme: const AppBarTheme(
            // iconTheme: IconThemeData(color: Colors.white),
          )
          // primarySwatch: Colors.blue,
          ),
      initialRoute: GlobalUtil.isViewed == 0 || GlobalUtil.isViewed == null
          ? AppRoutes.onBoardingScreen
          : AppRoutes.authHome,
      getPages: AppPages.appPages,
    );
  }
}

// ignore_for_file: prefer_const_declarations, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_soko/authentication/onboarding_screen.dart';
import 'package:m_soko/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF08215E),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF08215E),
        ),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => OnboardingBloc(),
        child: const MyAppRoot(),
      ),
    );
  }
}

class MyAppRoot extends StatelessWidget {
  const MyAppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = false;

    return isLoggedIn ? const HomeScreen() : OnboardingScreen();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:m_soko/authentication/Views/login_view.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/home/home_screen.dart';

class AuthHome extends StatelessWidget {
  const AuthHome({super.key});

  @override
  Widget build(BuildContext context) {
    final stream = FirebaseAuth.instance.authStateChanges();

    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (ConnectionState.waiting == snapshot.connectionState) {
          return Utils.customLoadingSpinner();
        } else if (snapshot.hasData) {
          return HomeScreen();
        }
        return const LoginView();
      },
    );
  }
}

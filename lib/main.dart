import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_soko/authentication/Views/login_view.dart';
import 'package:m_soko/authentication/Views/onboarding_screen.dart';
import 'package:m_soko/authentication/Views/register_view.dart';
import 'package:m_soko/authentication/auth_services/bloc/auth_bloc.dart';
import 'package:m_soko/authentication/auth_services/bloc/auth_event.dart';
import 'package:m_soko/authentication/auth_services/bloc/auth_state.dart';
import 'package:m_soko/authentication/auth_services/firebase_auth_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      // supportedLocales: AppLocalizations.supportedLocales,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorConstants.blue700,
        // primarySwatch: Colors.blue,

      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        // createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          Fluttertoast.showToast(msg: 'Loading');
        } else {
          Fluttertoast.showToast(msg: 'Loaded');
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return HomeScreen();
        } else if (state is AuthStateNeedsVerification) {
          return HomeScreen();
        } else if (state is AuthStateLoggedOut) {
          return const OnboardingScreen();
        }
        // else if (state is AuthStateForgotPassword) {
        //   return const ForgotPasswordView();
        // }
        else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else if (state is AuthStateLoging) {
          return const LoginView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_soko/authentication/auth_services/bloc/auth_bloc.dart';
import 'package:m_soko/authentication/auth_services/bloc/auth_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(
                  const AuthEventLogOut(),
                );
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}

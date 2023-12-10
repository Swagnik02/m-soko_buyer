import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_soko/authentication/auth_services/auth_service.dart';
import 'package:m_soko/authentication/auth_services/bloc/auth_bloc.dart';
import 'package:m_soko/authentication/auth_services/bloc/auth_event.dart';

class HomeScreen extends StatelessWidget {
  String get userId => AuthService.firebase().currentUser!.id;
  String get userName => AuthService.firebase().currentUser!.name;

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventLogOut(),
                    );
              },
              child: Text('Logout'),
            ),
            Text(userId),
            Text(userName),
          ],
        ),
      ),
    );
  }
}

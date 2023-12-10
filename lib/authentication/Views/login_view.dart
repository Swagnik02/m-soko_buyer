import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/authentication/auth_services/auth_exceptions.dart';
import 'package:m_soko/authentication/auth_services/bloc/auth_bloc.dart';
import 'package:m_soko/authentication/auth_services/bloc/auth_event.dart';
import 'package:m_soko/authentication/auth_services/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/common/colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool isPasswordVisible = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            Fluttertoast.showToast(msg: 'login_error_cannot_find_user');
          } else if (state.exception is WrongPasswordAuthException) {
            Fluttertoast.showToast(msg: 'login_error_wrong_credentials');
          } else if (state.exception is GenericAuthException) {
            Fluttertoast.showToast(msg: 'login_error_auth_error');
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Image.asset('assets/auth_header.png'),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 50, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Welcome to\nSokoni!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 35,
                    height: 8,
                    decoration: BoxDecoration(
                      color: ColorConstants.orange500,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),

            // main part
            Container(
              margin: const EdgeInsets.fromLTRB(30, 320, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email',
                    textAlign: TextAlign.right,
                  ),
                  TextField(
                    controller: _email,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConstants.blue700),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                    ),
                  ),

                  // password
                  const SizedBox(height: 8),
                  const Text('Password'),
                  TextField(
                    controller: _password,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConstants.blue700),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),

                  // forgot pass
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Forgot Password?',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Fluttertoast.showToast(
                                      msg: 'Forgot password');
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // seperator
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('or'),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  // social login
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(msg: 'Facebook login');
                        },
                        child: Container(
                          // padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Image.asset(
                            'assets/fb_sign.png',
                          ),
                        ),
                      ),
                      SizedBox(width: 0),
                      GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(msg: 'Google login');
                        },
                        child: Container(
                          // padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Image.asset(
                            'assets/google_sign.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Log In button
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    ColorConstants.blue700),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                // Fluttertoast.showToast(msg: 'btn pressed');
                                final email = _email.text;
                                final password = _password.text;
                                context.read<AuthBloc>().add(
                                      AuthEventLogIn(
                                        email,
                                        password,
                                      ),
                                    );
                              },
                              child: Container(
                                height: 35,
                                child: const Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Switch to Register section
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('New Here?'),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              Fluttertoast.showToast(
                                msg: 'Register Screen',
                              );
                              context.read<AuthBloc>().add(
                                    const AuthEventShouldRegister(),
                                  );
                            },
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                const BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                            child: const Text('Register'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/authentication/auth_services/auth_exceptions.dart';
import 'package:m_soko/authentication/auth_services/bloc/auth_bloc.dart';
import 'package:m_soko/authentication/auth_services/bloc/auth_event.dart';
import 'package:m_soko/authentication/auth_services/bloc/auth_state.dart';
import 'package:m_soko/common/colors.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isPasswordVisible1 = false;
  bool isPasswordVisible2 = false;
  late final TextEditingController _fname;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  @override
  void initState() {
    _fname = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fname.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            Fluttertoast.showToast(msg: 'register_error_weak_password');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            Fluttertoast.showToast(msg: 'register_error_email_already_in_use');
          } else if (state.exception is GenericAuthException) {
            Fluttertoast.showToast(msg: 'register_error_generic');
          } else if (state.exception is InvalidEmailAuthException) {
            Fluttertoast.showToast(msg: 'register_error_invalid_email');
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // header part
            Image.asset('assets/register_header.png'),

            Container(
              margin: const EdgeInsets.fromLTRB(30, 50, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Create new\naccount',
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
              margin: const EdgeInsets.fromLTRB(30, 250, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //name
                  const Text(
                    'Full name',
                    textAlign: TextAlign.right,
                  ),
                  TextField(
                    controller: _fname,
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

                  // email
                  const SizedBox(height: 8),
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
                    obscureText: !isPasswordVisible1,
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
                          isPasswordVisible1
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible1 = !isPasswordVisible1;
                          });
                        },
                      ),
                    ),
                  ),

                  // confirm password
                  const SizedBox(height: 8),
                  const Text('Confirm Password'),
                  TextField(
                    controller: _confirmPassword,
                    obscureText: !isPasswordVisible2,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConstants.blue700),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 16.0,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible2
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible2 = !isPasswordVisible2;
                          });
                        },
                      ),
                    ),
                  ),

                  // seperator
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(msg: 'Facebook signup');
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
                      const SizedBox(width: 0),
                      GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(msg: 'Google signup');
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
                  // Sign Up button
                  const SizedBox(height: 5),
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
                                final name = _fname.text;
                                context.read<AuthBloc>().add(
                                      AuthEventRegister(
                                        email,
                                        password,
                                        name,
                                      ),
                                    );
                              },
                              child: Container(
                                height: 35,
                                child: const Center(
                                  child: Text(
                                    'Sign Up!',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // switch to login
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'By signing up, you agree to our ',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms And Policy',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Implement your navigation or action here
                                  print('Navigate to Terms And Policy');
                                },
                            ),
                          ],
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Have an account?'),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              Fluttertoast.showToast(
                                msg: 'Login Screen',
                              );
                              context.read<AuthBloc>().add(
                                    const AuthEventShouldLogin(),
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

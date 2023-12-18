import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/authentication/Views/loginView/loginController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/routes/appRoutes.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset('assets/auth_header.png'),
          

                    Container(
            margin: const EdgeInsets.fromLTRB(30, 50, 30, 0),
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
                  controller: controller.email,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.blue700),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  ),
                ),

                // password
                SizedBox(height: Get.height * 0.01),
                const Text('Password'),
                GetBuilder<LoginController>(
                  builder: (_) => TextField(
                    controller: controller.password,
                    obscureText: !controller.isPasswordVisible,
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
                          controller.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () => controller.togglePasswordVisibleFunc(),
                      ),
                    ),
                  ),
                ),

                // forgot pass
                SizedBox(height: Get.height * 0.02),
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
                                Fluttertoast.showToast(msg: 'Forgot password');
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
                SizedBox(height: Get.height * 0.02),
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
                              controller.logIn();
                            },
                            child: const SizedBox(
                              height: 35,
                              child: Center(
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
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            Fluttertoast.showToast(
                              msg: 'Register Screen',
                            );
                            Get.toNamed(AppRoutes.registerScreen);
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
    );
  }
}

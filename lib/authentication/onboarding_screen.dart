import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_soko/authentication/login_screen.dart';
import 'package:m_soko/common/colors.dart';

class OnboardingBloc extends Bloc<OnboardingEvents, OnboardingStates> {
  OnboardingBloc() : super(OnboardingStates()) {
    on<OnboardingEvents>((event, emit) {
      return emit(OnboardingStates(pageIndex: state.pageIndex));
    });
  }
}

class OnboardingStates {
  int pageIndex;

  OnboardingStates({this.pageIndex = 0});
}

class OnboardingEvents {}

class Onboarding extends StatelessWidget {
  final String demoText =
      'Lorem ipsum dolor sit amet consectetur adipisicing elit.';
  final PageController controller = PageController(initialPage: 0);
  Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08215E),
      body: BlocBuilder<OnboardingBloc, OnboardingStates>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              PageView(
                controller: controller,
                onPageChanged: (value) {
                  state.pageIndex = value;
                  BlocProvider.of<OnboardingBloc>(context)
                      .add(OnboardingEvents());
                },
                children: [
                  _page(
                    context: context,
                    pageIndex: 0,
                    imageUrl: 'assets/auth/onboard1.png',
                    desc1: demoText,
                    desc2: demoText,
                    desc3: demoText,
                  ),
                  _page(
                    context: context,
                    pageIndex: 1,
                    imageUrl: 'assets/auth/onboard2.png',
                    desc1: demoText,
                    desc2: demoText,
                    desc3: demoText,
                  ),
                  _page(
                    context: context,
                    pageIndex: 2,
                    imageUrl: 'assets/auth/onboard3.png',
                    desc1: demoText,
                    desc2: demoText,
                    desc3: demoText,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _page({
    required pageIndex,
    required imageUrl,
    required desc1,
    required desc2,
    required desc3,
    required BuildContext context,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Image.asset(
          imageUrl,
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              _buildListItem(desc1),
              _buildListItem(desc2),
              _buildListItem(desc3),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  pageIndex == 2
                      ? Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        }))
                      : controller.animateToPage(pageIndex + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                },
                child: Container(
                  width: 150,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorConstants.orange500,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        pageIndex == 2 ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildListItem(String desc) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              desc,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.white,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

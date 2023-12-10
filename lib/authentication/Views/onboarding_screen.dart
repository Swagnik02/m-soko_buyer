import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_soko/widgets/onboard_page.dart';

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

class OnboardingScreen extends StatelessWidget {
  final String demoText =
      'Lorem ipsum dolor sit amet consectetur adipisicing elit.';
  final PageController controller = PageController(initialPage: 0);

  OnboardingScreen({super.key});

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
                  OnboardPage(
                    controller: controller,
                    pageIndex: 0,
                    imageUrl: 'assets/auth/onboard1.png',
                    desc1: demoText,
                    desc2: demoText,
                    desc3: demoText,
                  ),
                  OnboardPage(
                    controller: controller,
                    pageIndex: 1,
                    imageUrl: 'assets/auth/onboard2.png',
                    desc1: demoText,
                    desc2: demoText,
                    desc3: demoText,
                  ),
                  OnboardPage(
                    controller: controller,
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
}

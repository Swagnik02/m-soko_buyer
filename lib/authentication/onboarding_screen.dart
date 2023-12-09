import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define events for the onboarding screen
abstract class OnboardingEvent {}

class NextEvent extends OnboardingEvent {}

// Define states for the onboarding screen
abstract class OnboardingState {}

class InitialState extends OnboardingState {}

class SecondScreenState extends OnboardingState {}

class ThirdScreenState extends OnboardingState {}

// Define the onboarding BLoC
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(InitialState());

  @override
  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
    if (event is NextEvent) {
      if (state is InitialState) {
        yield SecondScreenState();
      } else if (state is SecondScreenState) {
        yield ThirdScreenState();
      }
    }
  }
}

// Define the onboarding screen widget
class OnboardingScreen extends StatelessWidget {
  final OnboardingBloc bloc = OnboardingBloc();

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is InitialState) Text('Onboarding Screen 1'),
                  if (state is SecondScreenState) Text('Onboarding Screen 2'),
                  if (state is ThirdScreenState) Text('Onboarding Screen 3'),
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(NextEvent());
                    },
                    child: Text('Next'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

// States
abstract class AuthenticationState {}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationSuccessState extends AuthenticationState {}

class AuthenticationFailureState extends AuthenticationState {
  final String error;

  AuthenticationFailureState({required this.error});
}

// Bloc
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitialState());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield AuthenticationLoadingState();

      try {
        // Perform your authentication logic here
        if (event.email == 'admin@gmail.com' && event.password == 'adminpass') {
          // Simulating a successful login
          yield AuthenticationSuccessState();
        } else {
          // Simulating a failed login
          yield AuthenticationFailureState(error: 'Invalid credentials');
        }
      } catch (e) {
        // If failed, yield AuthenticationFailureState
        yield AuthenticationFailureState(error: 'Login failed');
      }
    }
  }
}

import 'package:fluttertoast/fluttertoast.dart';

class WeakPasswordException implements Exception {
  @override
  String toString() {
    Fluttertoast.showToast(
        msg: 'Weak Password', toastLength: Toast.LENGTH_SHORT);
    return 'Weak Password';
  }
}

class EmailAlreadyInUseException implements Exception {
  @override
  String toString() {
    Fluttertoast.showToast(
        msg: 'Email is already in use', toastLength: Toast.LENGTH_SHORT);
    return 'Email is already in use';
  }
}

class InvalidEmailException implements Exception {
  @override
  String toString() {
    Fluttertoast.showToast(
        msg: 'Invalid Email', toastLength: Toast.LENGTH_SHORT);
    return 'Invalid Email';
  }
}

class AuthException implements Exception {
  @override
  String toString() {
    Fluttertoast.showToast(
        msg: 'Authentication Error', toastLength: Toast.LENGTH_SHORT);
    return 'Authentication Error';
  }
}

class EmptyFieldException implements Exception {
  final String fieldName;

  EmptyFieldException(this.fieldName);

  @override
  String toString() {
    Fluttertoast.showToast(
        msg: '$fieldName cannot be empty', toastLength: Toast.LENGTH_SHORT);
    return '$fieldName cannot be empty';
  }
}

class InvalidCredentialsException implements Exception {
  @override
  String toString() {
    Fluttertoast.showToast(
        msg: 'Invalid email or password', toastLength: Toast.LENGTH_SHORT);
    return 'Invalid email or password';
  }
}

class NetworkErrorException implements Exception {
  @override
  String toString() {
    Fluttertoast.showToast(
        msg: 'Network error occurred', toastLength: Toast.LENGTH_SHORT);
    return 'Network error occurred';
  }
}

import 'package:flutter/material.dart';
import '../ui/my_snackbar.dart';
import '../services/user_service.dart';

Future<void> newUserSignup(BuildContext context, GlobalKey<FormState> _formkey,
    String userName, String name, String password, String email) async {
  final UserService _userService = UserService();
  var formKey = _formkey;

  if (formKey.currentState!.validate()) {
    int responseCode =
        await _userService.attemptSignUp(userName, name, password, email);
    if (responseCode == 201) {
      const String message = 'Registration succesfull!';
      showSnackBar(
        message,
        context,
      );
      Navigator.pop(context);
    } else if (responseCode == 400) {
      const String message = 'Registration failed - username taken!';
      showSnackBar(message, context, isError: true);
      Navigator.pop(context);
    } else {
      const String message = 'Something went wrong!';
      showSnackBar(message, context, isError: true);
      Navigator.pop(context);
    }
  }
}

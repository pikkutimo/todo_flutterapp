import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../ui/my_snackbar.dart';
import '../ui/todo_page.dart';

Future<void> userLogin(
    BuildContext context, String userName, String password) async {
  final UserService _userService = UserService();

  try {
    var user = await _userService.attemptLogIn(userName, password);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoPage(user: user)),
    );
  } catch (e) {
    showSnackBar(e.toString().replaceAll('Exception:', ''), context);
    Navigator.pop(context);
  }
}

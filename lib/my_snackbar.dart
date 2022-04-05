import 'package:flutter/material.dart';

showSnackBar(String message, BuildContext context, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: isError ? Colors.red : Colors.blue,
    duration: const Duration(seconds: 5),
  ));
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/methods/validator.dart';

void main() {
  testWidgets('The validator validates the imputs according to the set rules',
      (WidgetTester tester) async {
    final _validator = Validator();
    final message = "Fail!";

    final emptyResult = _validator.isNameEmpty("", message);
    expect(emptyResult, "Fail!", reason: "The input has to contain something");

    final nonEmptyResult = _validator.isNameEmpty("Test", message);
    expect(nonEmptyResult, null);
  });
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart' show expect, group, test;
import '../lib/methods/validator.dart';

void main() {
  group("Validator", () {
    test("#1 The validator fail empty inputs", () {
      final _validator = Validator();
      const message = "Fail!";

      final emptyResult = _validator.isNameEmpty("", message);
      expect(emptyResult, "Fail!",
          reason: "The input has to contain something");
    });
    test("2# The validator validates non-empty inputs", () {
      final _validator = Validator();
      const message = "Fail!";

      final nonEmptyResult = _validator.isNameEmpty("Test", message);
      expect(nonEmptyResult, null);
    });

    test("3# The validator fails passwords that are less than 5 characters",
        () {
      final _validator = Validator();

      final emptyResult = _validator.isPassword("test");
      expect(emptyResult, "The password should countain at least 5 characters.",
          reason: "The password is only 3 characters");
    });
    test("4# The validator fails passwords that are empty", () {
      final _validator = Validator();

      final emptyResult = _validator.isPassword("");
      expect(emptyResult, "Please, enter a password.",
          reason: "The password is only 3 characters");
    });

    test("5# The validator validates passwords that are at least 5 characters",
        () {
      final _validator = Validator();

      final emptyResult = _validator.isPassword("Testi");
      expect(emptyResult, null);
    });

    test("6# The validator fails email addresses that aren't valid", () {
      final _validator = Validator();

      final emptyResult = _validator.emailValidator("Testi-Testi.fi");
      expect(emptyResult, "Please a valid Email");
    });

    test("6# The validator accepts valid email addresses", () {
      final _validator = Validator();

      final emptyResult = _validator.emailValidator("Testi@Testi.fi");
      expect(emptyResult, null);
    });

    test("7# The validator fail non-identical passwords", () {
      final _validator = Validator();

      final emptyResult = _validator.doPasswordsMatch("test", "testing");
      expect(emptyResult, "The passwords don't match.");
    });

    test("7# The validator validates identical passwords", () {
      final _validator = Validator();

      final emptyResult = _validator.doPasswordsMatch("test", "test");
      expect(emptyResult, null);
    });
  });
}

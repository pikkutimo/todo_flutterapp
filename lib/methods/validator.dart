class Validator {
  String? doPasswordsMatch(String password, String passwordAgain) {
    if (password != passwordAgain) {
      return 'The passwords don\'t match.';
    }

    return null;
  }

  String? isNameEmpty(String? value, String message) {
    if (value!.isEmpty) {
      return message;
    }
    return null;
  }

  String? isPassword(String password) {
    if (password.isNotEmpty && password.length > 4) {
      return null;
    } else if (password.isEmpty) {
      return 'Please, enter a password.';
    }

    return 'The password should countain at least 5 characters.';
  }

  String? emailValidator(String? value) {
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value!)) {
      return 'Please a valid Email';
    }
    return null;
  }
}

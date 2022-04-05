import 'package:flutter/material.dart';
import 'package:todo_flutterapp/dismiss_keyboard.dart';
import 'package:todo_flutterapp/user_service.dart';
import 'constants.dart';
import 'my_snackbar.dart';

class SignupDialog extends StatefulWidget {
  const SignupDialog({Key? key}) : super(key: key);

  @override
  _SignupDialogState createState() => _SignupDialogState();
}

class _SignupDialogState extends State<SignupDialog> {
  String name = "";
  String userName = "";
  String email = "";
  String password = "";
  TextEditingController userInput = TextEditingController();
  String text = "";
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.padding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      );
    });
  }

  contentBox(BuildContext context) {
    return Stack(children: <Widget>[
      DismissKeyboard(
          child: Container(
              height: 420,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Constants.padding),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: const <Widget>[
                        Expanded(
                          child: Text('REGISTER',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 18.0)),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5)),
                        focusColor: Colors.red,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        fillColor: Colors.grey,
                        hintText: ('What is your full name?'),
                        labelText: 'Name',
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) {
                        userName = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5)),
                        focusColor: Colors.red,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        fillColor: Colors.grey,
                        hintText: ('What is your username?'),
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5)),
                        focusColor: Colors.red,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        fillColor: Colors.grey,
                        hintText: ('What is your email?'),
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5)),
                        focusColor: Colors.red,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        fillColor: Colors.grey,
                        hintText: ('What is your password?'),
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        ElevatedButton(
                            onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              int responseCode =
                                  await _userService.attemptSignUp(
                                      userName, name, password, email);
                              if (responseCode == 201) {
                                const String message =
                                    'Registration succesfull!';
                                showSnackBar(
                                  message,
                                  context,
                                );
                                Navigator.pop(context);
                              } else if (responseCode == 400) {
                                const String message =
                                    'Registration failed - username taken!';
                                showSnackBar(message, context, isError: true);
                                Navigator.pop(context);
                              } else {
                                const String message = 'Something went wrong!';
                                showSnackBar(message, context, isError: true);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Register')),
                      ],
                    ),
                  ],
                ),
              )))
    ]);
  }
}

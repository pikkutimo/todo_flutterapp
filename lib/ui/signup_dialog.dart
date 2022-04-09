import 'package:flutter/material.dart';
import 'package:todo_flutterapp/ui/dismiss_keyboard.dart';
import '../constants.dart';
import '../methods/validator.dart';
import '../methods/user_tools.dart';

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
  String passwordAgain = "";
  TextEditingController userInput = TextEditingController();
  String text = "";

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

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
    UserTools _userTools = UserTools();
    Validator _validator = Validator();
    return Stack(children: <Widget>[
      DismissKeyboard(
          child: Container(
              height: 460,
              padding: const EdgeInsets.all(5.0),
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
                padding: const EdgeInsets.all(5),
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
                    const SizedBox(height: 5),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              onChanged: (value) {
                                name = value;
                              },
                              validator: (value) {
                                return _validator.isNameEmpty(
                                    value, 'Please enter a name');
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 0.5)),
                                focusColor: Colors.red,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 1.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: ('What is your full name?'),
                                labelText: 'Name',
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              onChanged: (value) {
                                userName = value;
                              },
                              validator: (value) {
                                return _validator.isNameEmpty(
                                    value, 'Please enter a username');
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 0.5)),
                                focusColor: Colors.red,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 1.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: ('What is your username?'),
                                labelText: 'Username',
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              onChanged: (value) {
                                email = value;
                              },
                              validator: (value) {
                                return _validator.emailValidator(value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 0.5)),
                                focusColor: Colors.red,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 1.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: ('What is your email?'),
                                labelText: 'Email',
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              onChanged: (value) {
                                password = value;
                              },
                              validator: (value) {
                                return _validator.isPassword(value!);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 0.5)),
                                focusColor: Colors.red,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 1.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: ('What is your password?'),
                                labelText: 'Password',
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              onChanged: (value) {
                                passwordAgain = value;
                              },
                              validator: (value) {
                                return _validator.doPasswordsMatch(
                                    password, passwordAgain);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 0.5)),
                                focusColor: Colors.red,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 1.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: ('Re-enter the password'),
                                labelText: 'Re-enter password',
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 10),
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
                              await _userTools.newUserSignup(context, _formKey,
                                  userName, name, password, email);
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

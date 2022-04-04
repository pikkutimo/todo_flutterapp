import 'package:flutter/material.dart';
import 'package:todo_flutterapp/signup_dialog.dart';
import 'todo_page.dart';
import 'user_service.dart';
import 'helper_dialog.dart';

const serverIp = 'https://rocky-harbor-47876.herokuapp.com/api';

void main() {
  runApp(const MyApp());
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserService _userService = UserService();

  // void displayDialog(context, title, text) => showDialog(
  //       context: context,
  //       builder: (context) =>
  //           AlertDialog(title: Text(title), content: Text(text)),
  //     );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Log In"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              TextButton(
                  onPressed: () async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;

                    try {
                      var user =
                          await _userService.attemptLogIn(username, password);
                      // storage.write(key: "username", value: user.username);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TodoPage(user: user)),
                      );
                    } catch (exception) {
                      displayDialog(context, "An Error Occurred",
                          "No account was found matching that username and password");
                    }
                  },
                  child: const Text("Log In")),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            const SignupDialog());
                  },
                  child: const Text("Sign Up"))
            ],
          ),
        ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter todo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginPage());
  }
}

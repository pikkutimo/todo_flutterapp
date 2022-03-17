import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
// import 'package:jwt_decode/jwt_decode.dart';

const SERVER_IP = 'https://rocky-harbor-47876.herokuapp.com/api';
final storage = FlutterSecureStorage();

void main() {
  runApp(MyApp());
}

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<String?> attemptLogIn(String username, String password) async {
    var res = await http.post(Uri.parse('$SERVER_IP/login'),
        body: {"username": username, "password": password});
    if (res.statusCode == 200) return res.body;
    return null;
  }

  Future<int> attemptSignUp(String username, String password) async {
    var res = await http.post(Uri.parse('$SERVER_IP/users'),
        body: {"username": username, "password": password});
    return res.statusCode;
  }

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
                    var jwt = await attemptLogIn(username, password);
                    if (jwt != null) {
                      storage.write(key: "jwt", value: jwt);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TodoPage()),
                      );
                    } else {
                      displayDialog(context, "An Error Occurred",
                          "No account was found matching that username and password");
                    }
                  },
                  child: const Text("Log In")),
              TextButton(
                  onPressed: () async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;

                    if (username.length < 4) {
                      displayDialog(context, "Invalid Username",
                          "The username should be at least 4 characters long");
                    } else if (password.length < 4) {
                      displayDialog(context, "Invalid Password",
                          "The password should be at least 4 characters long");
                    } else {
                      var res = await attemptSignUp(username, password);
                      if (res == 201) {
                        displayDialog(context, "Success",
                            "The user was created. Log in now.");
                      } else {
                        displayDialog(
                            context, "Error", "An unknown error occurred.");
                      }
                    }
                  },
                  child: const Text("Sign Up"))
            ],
          ),
        ));
  }
}

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
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

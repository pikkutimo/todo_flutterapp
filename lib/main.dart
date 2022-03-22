// ignore_for_file: no_logic_in_create_state

// import 'dart:collection';
import 'dart:convert';
// import 'dart:html';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const serverIp = 'https://rocky-harbor-47876.herokuapp.com/api';

void main() {
  runApp(const MyApp());
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<User> attemptLogIn(String username, String password) async {
    final response = await http.post(Uri.parse('$serverIp/login'),
        body: {"username": username, "password": password});
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<int> attemptSignUp(String username, String password) async {
    var res = await http.post(Uri.parse('$serverIp/users'),
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

                    try {
                      var user = await attemptLogIn(username, password);
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
  const TodoPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
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

class User {
  final String token;
  final String username;
  final String name;

  const User({
    required this.token,
    required this.username,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      username: json['username'],
      name: json['name'],
    );
  }
}

// class Todo {
//   final String content;
//   final bool important;
//   final bool done;

//   const Todo({
//     required this.content,
//     required this.important,
//     required this.done,
//   });

//   factory Todo.fromJson(Map<String, dynamic> json) {
//     return Todo(
//       content: json['content'] as String,
//       important: json['important'] as bool,
//       done: json['done'] as bool,
//     );
//   }
// }

// class TodosModel extends ChangeNotifier {
//   final List<Todo> _todos = [];

//   UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

//   void add(Todo todo) {
//     _todos.add(todo);
//     notifyListeners();
//   }

//   void remove(String content) {
//     _todos.removeWhere((todo) => todo.content == content);
//     notifyListeners();
//   }
// }

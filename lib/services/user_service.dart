import 'package:todo_flutterapp/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  final serverIp = 'https://rocky-harbor-47876.herokuapp.com/api';

  Future<User> attemptLogIn(String username, String password) async {
    final response = await http.post(Uri.parse('$serverIp/login'), body: {
      "username": username,
      "password": password,
    });
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Invalid username or password');
    }
  }

  Future<int> attemptSignUp(
      String userName, String name, String password, String email) async {
    var res = await http.post(Uri.parse('$serverIp/signup'), body: {
      "username": userName,
      "name": name,
      "password": password,
      "email": email
    });

    return res.statusCode;
  }
}

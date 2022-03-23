import 'dart:io';

import 'package:http/http.dart' as http;

class TodosService {
  void getTodos(String token) async {
    final response = await http.get(
      Uri.parse('https://rocky-harbor-47876.herokuapp.com/api/todos'),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer $token',
      },
    );

    print(response.body);
  }
}

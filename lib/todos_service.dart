import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'todos_model.dart';

class TodosService {
  Future<List<Todo>> fetchTodos(String token) async {
    final response = await http.get(
      Uri.parse('https://rocky-harbor-47876.herokuapp.com/api/todos'),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Todo>((json) => Todo.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }
}

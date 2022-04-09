import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/todos_model.dart';

class TodosService {
  Future<List<Todo>> fetchTodos(String token, http.Client client) async {
    final response = await client.get(
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

  Future<void> editTodo(
      Todo editedTodo, String token, http.Client client) async {
    final response = await client.put(
      Uri.parse(
          'https://rocky-harbor-47876.herokuapp.com/api/todos/${editedTodo.id}'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: 'bearer $token',
      },
      body: jsonEncode(Todo.toJson(editedTodo)),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update todos.');
    }
  }

  Future<void> addTodo(Todo newTodo, String token, http.Client client) async {
    final response = await client.post(
      Uri.parse('https://rocky-harbor-47876.herokuapp.com/api/todos'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: 'bearer $token',
      },
      body: jsonEncode(Todo.toJson(newTodo)),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add a new todo.');
    }
  }

  Future<void> deleteTodo(Todo todo, String token, http.Client client) async {
    final response = await client.delete(
      Uri.parse(
          'https://rocky-harbor-47876.herokuapp.com/api/todos/${todo.id}'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: 'bearer $token',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete the todo.');
    }
  }
}

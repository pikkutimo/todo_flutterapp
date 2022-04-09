import 'package:flutter/material.dart';
import '../models/todos_model.dart';
import '../services/todos_service.dart';
import 'my_snackbar.dart';
import 'package:http/http.dart' as http;

Future<void> addTodo(
    BuildContext dialogContext,
    String content,
    bool isImportant,
    bool isDone,
    String id,
    String userToken,
    http.Client client) async {
  final TodosService _todosService = TodosService();

  Todo newTodo = Todo(
    content: content,
    important: isImportant,
    done: isDone,
    id: id,
  );
  await _todosService.addTodo(newTodo, userToken, client);

  showSnackBar('Todo added"', dialogContext);
}

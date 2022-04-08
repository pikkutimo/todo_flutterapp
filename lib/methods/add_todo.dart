import 'package:flutter/material.dart';
import '../models/todos_model.dart';
import '../services/todos_service.dart';
import '../ui/my_snackbar.dart';

Future<void> addTodo(BuildContext dialogContext, String content,
    bool isImportant, bool isDone, String id, String userToken) async {
  final TodosService _todosService = TodosService();

  Todo newTodo = Todo(
    content: content,
    important: isImportant,
    done: isDone,
    id: id,
  );
  await _todosService.addTodo(newTodo, userToken);
  // ScaffoldMessenger.of(dialogContext).showSnackBar(
  //   const SnackBar(
  //     content: Text('Todo added!'),
  //     duration: Duration(seconds: 5),
  //   ),
  // );
  showSnackBar('Todo added"', dialogContext);
}

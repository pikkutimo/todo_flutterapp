import '../models/todos_model.dart';
import '../services/todos_service.dart';
import 'package:http/http.dart' as http;

class TodoTools {
  setTodoDone(Todo todo, String userToken, http.Client client) async {
    final TodosService todosService = TodosService();

    Todo editedTodo = Todo(
      content: todo.content,
      important: todo.important,
      done: todo.done ? false : true,
      id: todo.id,
    );

    await todosService.editTodo(editedTodo, userToken, client);
  }

  Future<void> editTodo(String content, bool isImportant, bool isDone,
      String id, String token, http.Client client) async {
    final TodosService _todosService = TodosService();

    Todo editedTodo = Todo(
      content: content,
      important: isImportant,
      done: isDone,
      id: id,
    );
    await _todosService.editTodo(editedTodo, token, client);
  }
}

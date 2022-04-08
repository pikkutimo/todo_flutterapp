import '../services/todos_service.dart';
import '../models/todos_model.dart';

Future<void> editTodo(String content, bool isImportant, bool isDone, String id,
    String token) async {
  final TodosService _todosService = TodosService();

  Todo editedTodo = Todo(
    content: content,
    important: isImportant,
    done: isDone,
    id: id,
  );
  await _todosService.editTodo(editedTodo, token);
}

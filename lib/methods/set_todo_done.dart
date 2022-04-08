import '../models/todos_model.dart';
import '../services/todos_service.dart';

setTodoDone(Todo todo, String userToken) async {
  final TodosService todosService = TodosService();

  Todo editedTodo = Todo(
    content: todo.content,
    important: todo.important,
    done: todo.done ? false : true,
    id: todo.id,
  );

  await todosService.editTodo(editedTodo, userToken);
}

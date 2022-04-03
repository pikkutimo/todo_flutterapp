import 'package:flutter/material.dart';
import 'package:todo_flutterapp/todos_service.dart';
import 'user_model.dart';
import 'todos_model.dart';

class EditTodo extends StatefulWidget {
  EditTodo({Key? key, required this.todo, required this.user})
      : super(key: key);

  final User user;
  final Todo todo;

  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  String userName = "";
  String token = "";
  String content = "";
  String id = "";
  bool isImportant = true;
  bool isDone = false;
  final TodosService _todosService = TodosService();

  @override
  void initState() {
    super.initState();
    userName = widget.user.username;
    token = widget.user.token;
    content = widget.todo.content;
    isImportant = widget.todo.important;
    isDone = widget.todo.done;
    id = widget.todo.id;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Text('Edit your todo, ' + userName),
        content: TextFormField(
          onChanged: (value) {
            content = value;
            // print(content);
          },
          initialValue: content,
        ),
        actions: <Widget>[
          Row(
            children: [
              Checkbox(
                value: isImportant,
                onChanged: (value) {
                  setState(() {
                    isImportant = !isImportant;
                  });
                },
              ),
              const Text('Important'),
              Checkbox(
                value: isDone,
                onChanged: (value) {
                  setState(() {
                    isDone = !isDone;
                  });
                },
              ),
              const Text('Done'),
            ],
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Column contents vertically,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Todo editedTodo = Todo(
                    content: content,
                    important: isImportant,
                    done: isDone,
                    id: id,
                  );
                  _todosService.editTodo(editedTodo, token);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ],
      );
    });
  }
}

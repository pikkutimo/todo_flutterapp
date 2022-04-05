import 'package:flutter/material.dart';
import 'package:todo_flutterapp/todos_service.dart';
import 'user_model.dart';
import 'todos_model.dart';
import 'constants.dart';
import 'dismiss_keyboard.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  String userName = "";
  String userToken = "";
  String content = "";
  String id = "mock";
  bool isImportant = true;
  bool isDone = false;
  final TodosService _todosService = TodosService();

  @override
  void initState() {
    super.initState();
    userName = widget.user.username;
    userToken = widget.user.token;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.padding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      );
    });
  }

  contentBox(BuildContext context) {
    return Stack(children: <Widget>[
      DismissKeyboard(
          child: Container(
              height: 260,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Constants.padding),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: const <Widget>[
                        Expanded(
                          child: Text('NEW TODO',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 18.0)),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) {
                        content = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5)),
                        focusColor: Colors.red,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        fillColor: Colors.grey,
                        hintText: ('What do you want to do?'),
                        labelText: 'Todo',
                      ),
                    ),
                    const SizedBox(height: 15),
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
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        ElevatedButton(
                            onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Todo newTodo = Todo(
                                content: content,
                                important: isImportant,
                                done: isDone,
                                id: id,
                              );
                              await _todosService.addTodo(newTodo, userToken);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Todo added!'),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            child: const Text('Add')),
                      ],
                    ),
                  ],
                ),
              )))
    ]);
  }
}

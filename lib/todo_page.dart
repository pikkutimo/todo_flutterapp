import 'package:flutter/material.dart';
import 'package:todo_flutterapp/todos_service.dart';
import 'add_dialog.dart';
import 'edit_dialog.dart';
import 'user_model.dart';
import 'todos_service.dart';
import 'todos_model.dart';
import 'dart:async';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late Future<List<Todo>> allTodos;
  String userName = "";
  String userToken = "";
  final TodosService todosService = TodosService();

  @override
  void initState() {
    super.initState();
    allTodos = todosService.fetchTodos(widget.user.token);
    userName = widget.user.username;
    userToken = widget.user.token;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Welcome, $userName!'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  // When logging off, you return back and all todos will be
                  // loaded again when logging in
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.logout,
                  size: 26.0,
                ),
              ),
            )
          ],
        ),
        body: FutureBuilder<List<Todo>>(
          future: allTodos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                      onTap: () {
                        print('tap');
                        setDone(snapshot.data![index]);
                      },
                      onDoubleTap: () async {
                        await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) => EditTodo(
                                  todo: snapshot.data![index],
                                  user: widget.user,
                                ));
                        setState(() {
                          allTodos = todosService.fetchTodos(widget.user.token);
                        });
                      },
                      child: Dismissible(
                          background: Container(
                            child: const Icon(Icons.delete_forever),
                            decoration: const BoxDecoration(color: Colors.red),
                          ),
                          key: UniqueKey(),
                          onDismissed: (DismissDirection direction) async {
                            await todosService.deleteTodo(
                                snapshot.data![index], userToken);
                            setState(() {
                              allTodos =
                                  todosService.fetchTodos(widget.user.token);
                            });
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                                leading: snapshot.data![index].done
                                    ? const Icon(
                                        Icons.check_box,
                                        color: Colors.green,
                                      )
                                    : const Icon(Icons.check_box_outline_blank),
                                title: snapshot.data![index].done
                                    ? Text(
                                        snapshot.data![index].content,
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      )
                                    : Text(
                                        snapshot.data![index].content,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                dense: true,
                                trailing: snapshot.data![index].important
                                    ? const Icon(
                                        Icons.priority_high,
                                        color: Colors.red,
                                      )
                                    : null),
                          )));
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => AddTodo(
                        user: widget.user,
                      ));
              setState(() {
                allTodos = todosService.fetchTodos(widget.user.token);
              });
            }),
      ),
    );
  }

  setDone(Todo todo) async {
    Todo editedTodo = Todo(
      content: todo.content,
      important: todo.important,
      done: todo.done ? false : true,
      id: todo.id,
    );

    await todosService.editTodo(editedTodo, userToken);
    setState(() {
      allTodos = todosService.fetchTodos(widget.user.token);
    });
  }
}

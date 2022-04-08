import 'package:flutter/material.dart';
import 'package:todo_flutterapp/services/todos_service.dart';
import 'add_dialog.dart';
import 'edit_dialog.dart';
import '../models/user_model.dart';
import '../services/todos_service.dart';
import '../models/todos_model.dart';
import '../methods/set_todo_done.dart';
import '../ui/profile_dialog.dart';
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
  String name = "";
  String userToken = "";
  final TodosService todosService = TodosService();

  @override
  void initState() {
    super.initState();
    allTodos = todosService.fetchTodos(widget.user.token);
    userName = widget.user.username;
    name = widget.user.name;
    userToken = widget.user.token;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('$userName\'s todos'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ProfileDialog(
                            user: User(
                                name: name,
                                username: userName,
                                token: userToken));
                      });
                },
                child: const Icon(
                  Icons.account_circle,
                  size: 26.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  // When logging off, you return back and all todos will be
                  // loaded again when logging in
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Icon(
                  Icons.logout,
                  size: 26.0,
                ),
              ),
            ),
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
                        setTodoDone(snapshot.data![index], userToken);
                        setState(() {
                          allTodos = todosService.fetchTodos(widget.user.token);
                        });
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
}

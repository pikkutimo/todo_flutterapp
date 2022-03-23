import 'package:flutter/material.dart';
import 'package:todo_flutterapp/todos_service.dart';
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
  late Future<List<Todo>> futureTodo;
  String userName = "";
  final TodosService _todosService = TodosService();

  @override
  void initState() {
    super.initState();
    futureTodo = _todosService.fetchTodos(widget.user.token);
    userName = widget.user.username;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('User: $userName'),
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
          future: futureTodo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xff97FFFF),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data![index].content,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ButtonBar(
                        children: [
                          OutlinedButton(
                              onPressed: () => print(userName),
                              child: const Text('Edit')),
                          OutlinedButton(
                              onPressed: () => print('importance'),
                              child: Text(snapshot.data![index].important
                                  ? 'Important'
                                  : 'Normal')),
                          OutlinedButton(
                              onPressed: () => print('done'),
                              child: Text(snapshot.data![index].done
                                  ? 'Done'
                                  : 'Todo')),
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user_model.dart';
// import 'todos_service.dart';
import 'todos_model.dart';
import 'dart:async';

Future<List<Todo>> fetchTodos(String token) async {
  final response = await http.get(
    Uri.parse('https://rocky-harbor-47876.herokuapp.com/api/todos'),
    headers: {
      HttpHeaders.authorizationHeader: 'bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Todo>((json) => Todo.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load todos');
  }
}

class TodoPage extends StatefulWidget {
  TodoPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late Future<List<Todo>> futureTodo;

  @override
  void initState() {
    super.initState();
    futureTodo = fetchTodos(widget.user.token);
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
          title: const Text('Fetch Data Example'),
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
                              onPressed: () => print('edit'),
                              child: Text('Edit')),
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
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

// class TodoPage extends StatelessWidget {
//   TodoPage({Key? key, required this.user}) : super(key: key);

//   final User user;
//   final todosService = TodosService();

//   void _fetch() {
//     todosService.getTodos(user.token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(user.username),
//         ),
//         body: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(children: <Widget>[
//               TextButton(
//                   onPressed: () async {
//                     _fetch();
//                   },
//                   child: const Text("Fetch")),
//             ])));
//   }
// }

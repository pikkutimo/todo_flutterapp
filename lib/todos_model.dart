import 'dart:convert';

List<Todo> todosFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromMap(x)));

class Todo {
  final String content;
  final bool important;
  final bool done;
  final String id;

  const Todo({
    required this.content,
    required this.important,
    required this.done,
    required this.id,
  });

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        content: json['content'] as String,
        important: json['important'] as bool,
        done: json['done'] as bool,
        id: json['id'] as String,
      );
}

import 'package:flutter/material.dart';
import 'package:todo_flutterapp/todos_service.dart';
import 'user_model.dart';
import 'todos_model.dart';

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
      return AlertDialog(
        title: const Text('Add a new todo'),
        content: TextFormField(
          decoration: const InputDecoration(hintText: 'Write your todo'),
          onChanged: (value) {
            content = value;
            // print(content);
          },
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
                  Todo newTodo = Todo(
                    content: content,
                    important: isImportant,
                    done: isDone,
                    id: id,
                  );
                  await _todosService.addTodo(newTodo, userToken);
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

// class AddTodoDialog extends StatelessWidget {
  // final String title, description, buttonText;
  // const AddTodoDialog({
  //   Key? key,
  //   required this.title,
  //   required this.description,
  //   required this.buttonText,
  // }) : super(key: key);
  // @override
  // Widget build(BuildContext context) {
  //   return Dialog(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(16.0),
  //     ),
  //     elevation: 0.0,
  //     backgroundColor: Colors.transparent,
  //     child: dialogContent(context),
  //   );
  // }

  // dialogContent(BuildContext context) {
  //   return Stack(
  //     children: <Widget>[
  //       Container(
  //         padding: const EdgeInsets.only(
  //           top: 66.0 + 16.0 * 12,
  //           bottom: 16.0,
  //           left: 16.0,
  //           right: 16.0,
  //         ),
  //         margin: const EdgeInsets.only(top: 66.0),
  //         decoration: BoxDecoration(
  //           color: Colors.black, //Colors.black.withOpacity(0.3),
  //           shape: BoxShape.rectangle,
  //           borderRadius: BorderRadius.circular(16.0),
  //           boxShadow: const [
  //             BoxShadow(
  //               color: Colors.black26,
  //               blurRadius: 10.0,
  //               offset: Offset(0.0, 10.0),
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min, // To make the card compact
  //           children: <Widget>[
  //             Text(
  //               title,
  //               style: const TextStyle(
  //                 fontSize: 24.0,
  //                 fontWeight: FontWeight.w700,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             const SizedBox(height: 16.0),
  //             Text(
  //               description,
  //               textAlign: TextAlign.center,
  //               style: const TextStyle(
  //                 fontSize: 16.0,
  //                 color: Colors.white70,
  //               ),
  //             ),
  //             const SizedBox(height: 24.0),
  //             Align(
  //               alignment: Alignment.bottomRight,
  //               child: TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(); // To close the dialog
  //                 },
  //                 child: Text(
  //                   buttonText,
  //                   style: const TextStyle(
  //                     color: Colors.purple,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const Positioned(
  //         left: 16.0,
  //         right: 16.0,
  //         child: CircleAvatar(
  //           backgroundColor: Colors.amber,
  //           radius: 150,
  //           backgroundImage: NetworkImage(
  //             '<https://upload.wikimedia.org/wikipedia/commons/1/1d/Rotating_Konarka_chaka.gif>',
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
// }

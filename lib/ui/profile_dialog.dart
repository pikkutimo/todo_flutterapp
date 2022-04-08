import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../constants.dart';
import 'dismiss_keyboard.dart';
import '../ui/helper_dialog.dart';

class ProfileDialog extends StatefulWidget {
  const ProfileDialog({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _ProfileDialogState createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  String userName = "";
  String name = "";
  String token = "";

  @override
  void initState() {
    super.initState();
    userName = widget.user.username;
    name = widget.user.name;
    token = widget.user.token;
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
              height: 250,
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
                          child: Text('USER PROFILE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 18.0)),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Name: $userName',
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Username: $userName',
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          displayDialog(context, 'Non-operational',
                              'Waiting for implementation in the backend.');
                        },
                        child: const Text('Change password')),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Navigator.pop(context);
                            },
                            child: const Text('Close')),
                      ],
                    ),
                  ],
                ),
              )))
    ]);
  }
}

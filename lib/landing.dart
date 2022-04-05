import 'package:flutter/material.dart';
import 'login_dialog.dart';
import 'signup_dialog.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(children: [
            const SizedBox(height: 25),
            Image.asset(
              'media/logo.png',
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const LoginPage();
                          });
                    },
                    child: const Text('Login')),
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const SignupDialog();
                          });
                    },
                    child: const Text('Signup')),
              ],
            ),
          ]),
        ));
  }
}

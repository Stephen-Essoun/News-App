import 'package:all_news/const/constant.dart';
import 'package:all_news/utilities/textfield.dart';
import 'package:all_news/view/email_auth_view/login_view.dart';
 import 'package:flutter/material.dart';

import '../../service/auth/email_auth.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController email;
  late final TextEditingController password;
  final EmailAuth _auth = EmailAuth();

  @override
  void initState() {
    _auth.context = context;
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
                child: Text(
              "Create Account",
              style: TextStyle(fontSize: 35),
            )),
            space2,
            customTextField(controller: email, labelText: 'Email'),
            space,
            customTextField(
              controller: password,
              labelText: 'Password',
            ),
            space,
            ElevatedButton(
                onPressed: () async {
                  if (isLoading == false) {
                    showDialog(
                        context: context,
                        builder: (_) => Center(child: spinkit));
                  } 
                  Future.delayed(
                    const Duration(seconds: 2),
                    () {
                      _auth.createUser(
                          email: email.text, password: password.text);
                    },
                  );
                },
                child: const Text('Register')),
            space,
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginView()),
                      (route) => false);
                },
                child: const Text("Already a member? Login."))
          ],
        ),
      ),
    ));
  }
}

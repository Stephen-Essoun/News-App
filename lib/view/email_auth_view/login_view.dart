import 'package:all_news/const/constant.dart';
import 'package:all_news/utilities/textfield.dart';
import 'package:all_news/view/email_auth_view/register_view.dart';
import 'package:flutter/material.dart';
import '../../service/auth/email_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
                child: Text(
              "Welcome back",
              style: TextStyle(fontSize: 35),
            )),
            space2,
            customTextField(controller: email, labelText: 'Email'),
            space,
            customTextField(
              controller: password,
              labelText: 'Password',
              obscureText: true,
            ),
            space,
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _auth.loginUser(
                      email: email.text.trim(),
                      password: password.text.trim(),
                    );
                  }
                },
                child: const Text('Login')),
            space,
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const RegisterView()),
                    (route) => false);
              },
              child: const Text(
                "Don't have an account yet? Register",
                style: TextStyle(color: Color(0xff8d0000)),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

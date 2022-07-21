import 'package:chedda/service/auth/email_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        TextField(controller: _email,),
        TextField(controller: _password,),
        TextButton(onPressed: () {
          EmailAuth(email:_email,password:_password).loginUser();
        }, child: Text('Login'))
      ],
    ));
  }
}

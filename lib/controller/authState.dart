// ignore_for_file: file_names

import 'dart:developer' show log;
import 'package:all_news/service/auth/email_auth.dart';
import 'package:all_news/view/email_auth_view/login_view.dart';
import 'package:all_news/view/email_auth_view/verify_view.dart';
import 'package:all_news/view/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthState extends StatefulWidget {
  const AuthState({Key? key}) : super(key: key);

  @override
  State<AuthState> createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailAuth>(builder: (context, snapshot) {
      var user = context.read<EmailAuth>().currentuser;
      if (user != null) {
        log("${user.emailVerified}");
        if (user.emailVerified) {
          return const Home();
        } else if (user.emailVerified == false) {
          return const EmailVerifyView();
        }
      }
      return const LoginView();
    }, stream: null,);
  }
}

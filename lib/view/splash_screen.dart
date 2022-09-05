import 'package:all_news/controller/authState.dart';
import 'package:all_news/view/email_auth_view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    navigateTo();
    super.initState();
  }

  navigateTo() async {
    await Future.delayed(const Duration(seconds: 3), () {
     return  Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const AuthState()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/bg.png'))),
    );
  }
}

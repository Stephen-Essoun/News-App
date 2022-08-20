import 'package:all_news/view/email_auth_view/login_view.dart';
import 'package:all_news/view/sign_in.dart';
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
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => StreamBuilder<User?>(builder: (_,snapshot){
      if(snapshot.hasData){
        return const Home();
      }
      if(snapshot.hasError){
        return Scaffold(body: Center(child: Text(snapshot.error.toString()),),);
      }
      return const LoginView();
    },stream: FirebaseAuth.instance.authStateChanges()),));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(image:DecorationImage(image: AssetImage('assets/images/bg.png')) ),
    );
  }
}
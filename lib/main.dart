import 'package:all_news/const/routes.dart';
import 'package:all_news/service/auth/email_auth.dart';
import 'package:all_news/view/email_auth_view/login_view.dart';
import 'package:all_news/view/email_auth_view/register_view.dart';
import 'package:all_news/view/email_auth_view/verify_view.dart';
import 'package:all_news/view/home.dart';
import 'package:all_news/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  // Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => EmailAuth())],
    builder: (context, child) => 
    MaterialApp(
      home: const Splash(),
      debugShowCheckedModeBanner: false,
      routes: {
        signInRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        homeRoute: (context) => const Home(),
        emailVerifyRoute: (context) => const EmailVerifyView(),
      },
      theme: ThemeData(
          errorColor: Colors.red,
          appBarTheme: const AppBarTheme(
              elevation: 2, color: Color.fromARGB(255, 178, 91, 91)),
          hintColor: const Color(0xFFDAD7DF)),
    ),
  ));
}

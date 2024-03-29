import 'package:all_news/const/routes.dart';
import 'package:all_news/controller/authState.dart';
import 'package:all_news/service/auth/email_auth.dart';
import 'package:all_news/view/email_auth_view/login_view.dart';
import 'package:all_news/view/email_auth_view/register_view.dart';
import 'package:all_news/view/email_auth_view/verify_view.dart';
import 'package:all_news/view/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  // Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => EmailAuth())],
    builder: (context, child) => MaterialApp(
      builder: EasyLoading.init(),
      home: const AuthState(),
      debugShowCheckedModeBanner: false,
      routes: {
        signInRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        homeRoute: (context) => const Home(),
        emailVerifyRoute: (context) => const EmailVerifyView(),
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(elevation: 0, color: Color(0xff8d0000)),
        hintColor: const Color(0xFFDAD7DF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff8d0000)),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
              const TextStyle(decorationColor: Color(0xff8d0000))),
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0xff8d0000),
            ),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
      ),
    ),
  ));
}

import 'package:all_news/const/constant.dart';
import 'package:all_news/view/email_auth_view/register_view.dart';
import 'package:all_news/view/sign_in.dart';
import 'package:all_news/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
 
void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MaterialApp(
    home:const Splash(),debugShowCheckedModeBanner: false,
    routes: {
      signInRoute :(context) => const SignIn(),
      registerRoute :(context) => const RegisterView()
    },
     theme: ThemeData(
      errorColor: Colors.red,
       appBarTheme:const AppBarTheme(elevation: 2,
       color:Color.fromARGB(255, 178, 91, 91) ),
       hintColor: const Color(0xFFDAD7DF) 
     ),
  ));
}

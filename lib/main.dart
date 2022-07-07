import 'package:chedda/screen/home.dart';
import 'package:chedda/screen/sign_in.dart';
import 'package:chedda/screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(MaterialApp(
    home:Splash(),debugShowCheckedModeBanner: false,
     theme: ThemeData(
      errorColor: Colors.red,
       appBarTheme: AppBarTheme(elevation: 2,
       color:Color.fromARGB(255, 178, 91, 91) ),
       hintColor: Color(0xFFDAD7DF) 
     ),
  ));
}

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
     theme: ThemeData(
      errorColor: Colors.red,
       appBarTheme:const AppBarTheme(elevation: 2,
       color:Color.fromARGB(255, 178, 91, 91) ),
       hintColor: Color(0xFFDAD7DF) 
     ),
  ));
}

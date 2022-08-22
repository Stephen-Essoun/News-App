import 'package:all_news/const/constant.dart';
import 'package:all_news/utilities/fuctions.dart';
import 'package:all_news/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devprint show log;
import 'package:flutter/material.dart';

class EmailAuth {
  late BuildContext context;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentuser => _firebaseAuth.currentUser;

  void createUser({required String email, required String password}) async {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => verifyUser());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        devprint.log('Email already in use');
        return dialogue(context,
            content: const Text(
              "Email already in use",
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok')),
            ]);
      } else if (e.code == 'invalid-email') {
        devprint.log('Invalid email account');
        return dialogue(context,
            content: const Text(
              "Invalid email account",
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok')),
            ]);
      } else if (e.code == 'operation-not-allowed') {
        devprint.log("Can't login with this credentials");
        return dialogue(context,
            content: const Text(
              "Can't login with these\ncredentials",
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok')),
            ]);
      }
    }
  }

  void loginUser({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const Home()),
              (route) => false));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        devprint.log('Incorrect password');
        return dialogue(context,
            content: const Text(
              "Incorrect password",
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok')),
            ]);
      } else if (e.code == 'invalid-email') {
        devprint.log('Invalid email address');
        return dialogue(context,
            content: const Text(
              "Invalid email address",
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok')),
            ]);
      } else if (e.code == 'user-not-found') {
        devprint.log("No account found under this credentials");
        return dialogue(context,
            content: const Text(
              "No account found under\nthis credentials",
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok')),
            ]);
      }
    }
  }

  void handleSignOut() async {
    await _firebaseAuth.signOut();
  }

  void verifyUser() async {
    // final user = _firebaseAuth.currentUser;
    await currentuser!.sendEmailVerification();
  }
}

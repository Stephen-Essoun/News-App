import 'package:all_news/const/constant.dart';
import 'package:all_news/const/routes.dart';
import 'package:all_news/utilities/fuctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devprint show log;
import 'package:flutter/material.dart';

class EmailAuth extends ChangeNotifier {
  late BuildContext context;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentuser => _firebaseAuth.currentUser;

   createUser({required String email, required String password}) async {
    // showDialog(context: context, builder: (ctx)=> Center(child: spinkit));
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => Navigator.of(context)
              .pushNamedAndRemoveUntil(emailVerifyRoute, (route) => false));
    } on FirebaseAuthException catch (e) {
      devprint.log(e.code);
      if (e.code == 'email-already-in-use') {
        devprint.log('Incorrect password');
        return dialogue(context,
            content: const Text(
              "This account is used\nby another person",
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok')),
            ]);
      } else if (e.code == 'weak-password') {
        devprint.log('password');
        return dialogue(context,
            content: const Text(
              "Enter password at\nleast 6 charactors",
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok')),
            ]);
      } else if (e.code == 'unknown') {
        devprint.log('field');
        return dialogue(context,
            content: const Text(
              "Fields can't be empty",
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok')),
            ]);
      } else if (e.code == 'invalid-email') {
        devprint.log('email');
        return dialogue(context,
            content: const Text(
              "Enter a valid email",
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok')),
            ]);
      } else if (e.code == 'operation-not-allowed') {
        devprint.log("Can't signup with this credentials");
        return dialogue(context,
            content: const Text(
              "Can't signup with these\ncredentials",
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok')),
            ]);
      } else {
        devprint.log('uncaught');
        return dialogue(context,
            content: Text(
              e.code,
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok')),
            ]);
      }
    }
  }

   loginUser({required String email, required String password}) async {
    // showDialog(context: context, builder: (ctx) => Center(child: spinkit));
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Navigator.of(context)
              .pushNamedAndRemoveUntil(homeRoute, (route) => false));
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
        devprint.log("No account found under these credentials");
        return dialogue(context,
            content: const Text(
              "No account found under\nthese credentials",
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok')),
            ]);
      }
    }
  }

   handleSignOut() async {
    // showDialog(context: context, builder: (ctx) => Center(child: spinkit));
    await _firebaseAuth.signOut().then((value) => Navigator.of(context)
        .pushNamedAndRemoveUntil(signInRoute, (route) => false));
  }

  void verifyUser() async {
    // final user = _firebaseAuth.currentUser;
    try {
      await currentuser!.sendEmailVerification().then((value) {
        currentuser!.reload();
      });
    } catch (e) {
      print(e);
    }
  }
}

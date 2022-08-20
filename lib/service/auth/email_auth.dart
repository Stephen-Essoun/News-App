import 'dart:developer' as devprint show log;

import 'package:all_news/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void createUser({required String email, required String password}) async {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => verifyUser());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        devprint.log('Email already in use');
      } else if (e.code == 'invalid-email') {
        devprint.log('Invalid email account');
      } else if (e.code == 'operation-not-allowed') {
        devprint.log("Can't login wit this account");
      }
    }
  }

  void loginUser({required String email, required String password}) async {
    try {
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        devprint.log('Incorrect password');
      } else if (e.code == 'invalid-email') {
        devprint.log('Invalid email address');
      } else if (e.code == 'user-not-found') {
        devprint.log("No account found under this credentials");
      }
    }
  }

  void handleSignOut() async {
    await _firebaseAuth.signOut();
  }

  void verifyUser() async {
    final user = _firebaseAuth.currentUser;
    await user!.sendEmailVerification();
  }
}

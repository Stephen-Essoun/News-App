import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devprint show log;

class EmailAuth {
  late final email;
  late final password;
  EmailAuth({this.email,this.password});

  void createUser() async {
    try {
      final user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email,password: password)
          .then((value) => null);
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

  void loginUser ()async{
    try{
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
       if (e.code == 'wrong-password') {
        devprint.log('Incorrect password');
      } else if (e.code == 'invalid-email') {
        devprint.log('Invalid email address');
      } else if (e.code == 'user-not-found') {
        devprint.log("No account found under this credentials");
      }
    }
  }

  void verifyUser()async{
    final user =  FirebaseAuth.instance.currentUser;
    await user!.sendEmailVerification();
  }
}

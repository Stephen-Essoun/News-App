import 'package:chedda/view/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class PhoneAuth  {
  late bool otpVisible;
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIdRecieved = '';
  verifyFone() async {
    await auth.verifyPhoneNumber(
        phoneNumber:'+233${phoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) {
          print('verificated complete');
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.code);
        },
        codeSent: (String verificationId, int? resenToken) {
          verificationIdRecieved = verificationId;
          otpVisible = true;
          
        },
        forceResendingToken: 6,
        timeout: Duration(seconds: 15),
        codeAutoRetrievalTimeout: (String verificationId) {});
  }
  

  verifyOtp() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdRecieved, smsCode: otpController.text);
    await auth.signInWithCredential(credential).then((value) {
      print('login complete');
    });
  }
  }

  @override
  String toStringDeep({String prefixLineOne = '', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toStringDeep
    throw UnimplementedError();
  }

  @override
  String toStringShallow({String joiner = ', ', DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toStringShallow
    throw UnimplementedError();
  }

  @override
  String toStringShort() {
    // TODO: implement toStringShort
    throw UnimplementedError();
  }


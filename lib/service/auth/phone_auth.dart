import 'package:all_news/view/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devprint show log;


class PhoneAuth {
  bool otpvisible = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIdRecieved = '';
  int? _resendToken;
  verifyFone() async {
    await auth.verifyPhoneNumber(
      phoneNumber: editedPhone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (
        String verificationId,
        int? resendToken,
      ) async {
        verificationIdRecieved = verificationId;
        otpvisible = true;
        _resendToken = resendToken;
      },
      forceResendingToken: _resendToken,
      timeout: const Duration(
        seconds: 10,
      ),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyOtp() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIdRecieved,
      smsCode: otpController.text,
    );
    await auth.signInWithCredential(credential).then(
      (value) {
        devprint.log('All done');
      },
    );
  }
}

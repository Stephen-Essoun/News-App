import 'package:chedda/screen/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth  {
  bool otpVisible = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIdRecieved = '';
  verifyFone() async {
    await auth.verifyPhoneNumber(
        phoneNumber:'+233${phoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) {
          print('verificated complete');
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
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

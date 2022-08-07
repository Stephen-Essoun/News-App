import 'package:chedda/view/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuth {
  bool otpvisible = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIdRecieved = '';
  int? _resendToken;
  verifyFone() async {
    await auth.verifyPhoneNumber(
      phoneNumber: '${country_code_picker+phoneController.text}',
      verificationCompleted: (PhoneAuthCredential credential) {
        print('verificated complete');
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.code);
      },
      codeSent: (
        String verificationId,
        int? resendToken,
      ) async {
        verificationIdRecieved = verificationId;
        otpvisible = true;
        _resendToken = resendToken;
      },
      forceResendingToken: _resendToken,
      timeout: Duration(
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
          (value) {},
        );
  }
}

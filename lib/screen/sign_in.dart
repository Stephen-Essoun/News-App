import 'package:chedda/screen/home.dart';
import 'package:chedda/widget/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

TextEditingController phoneController = TextEditingController();
TextEditingController otpController = TextEditingController();


class _SignInState extends State<SignIn> {
  final  spinkit = SpinKitCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      );
    },
  );
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        color: Colors.black26,
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.png'), fit: BoxFit.fill)),
      child: FutureBuilder<Object>(
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customTextField(
                      hintText: 'Phone',
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a phone number';
                        }
                       else if (value.length < 10 || value.length > 14) {
                          return 'Invalid input';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                        visible: otpVisible,
                        child: customTextField(
                            hintText: 'Enter code recieved',
                            controller: otpController)),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (otpVisible) {
                            verifyOtp();
                            setState(() {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) => Home()));
                              phoneController.clear();
                              otpController.clear();
                            });
                          } else {                            verifyFone();
                          setState(() {
                            
                          });
                          }
                        }
                      },
                      child: Text(otpVisible ? 'Verify' : 'Continue'),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  bool otpVisible = false;
  bool doing = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIdRecieved = '';
  verifyFone() async {
    await auth.verifyPhoneNumber(
        phoneNumber: '+233${phoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) {
          print('verificated complete');
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resenToken) {
          verificationIdRecieved = verificationId;
          setState(() {
            otpVisible = true;
          });
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

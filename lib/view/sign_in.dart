import 'package:chedda/reusable/progres_indicator.dart';
import 'package:chedda/service/auth/phone_auth.dart';
import 'package:chedda/view/home.dart';
import 'package:chedda/reusable/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:developer' show log;

final _auth = PhoneAuth();

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

late TextEditingController phoneController;
late TextEditingController otpController;

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  bool isPressed = false;

  @override
  void initState() {
    phoneController = TextEditingController();
    otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

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
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            return Form(
              key: _formKey,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customTextField(
                        hintText: 'Phone',
                        controller: phoneController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your phone number';
                          } else if (value.length < 10 || value.length > 14) {
                            return 'Invalid input';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          log('pressed');
                          if (_formKey.currentState!.validate()) {
                            try {
                              // _auth.verifyFone();
                              Future.delayed(Duration(seconds: 1), () {
                                return otpCodeTextFied(context);
                              });
                            } on FirebaseAuthException catch (e) {
                              switch (e) {
                              }
                            }
                          }
                        },
                        child: Text(
                          'Verify',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  ////////////////////////////////////////////////////
  otpCodeTextFied(BuildContext context) {
    return showDialog(
      context: (context),
      builder: (_) => AlertDialog(
        title: customTextField(
          controller: otpController,
          hintText: 'Enter code recieved',
        ),
        actions: [
          TextButton(
            onPressed: () {
              _auth.verifyFone();
            },
            child: Text('Resend code'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          Visibility(visible: _auth.otpvisible,
            child: TextButton(
              onPressed: ()  {
                //  _auth.verifyOtp();
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Home(),
                    ),
                  );
                });
              },
              child: Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}

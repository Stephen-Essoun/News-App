import 'package:chedda/reusable/progres_indicator.dart';
import 'package:chedda/service/auth/phone_auth.dart';
import 'package:chedda/view/home.dart';
import 'package:chedda/reusable/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:developer'show log;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

late  TextEditingController phoneController;
late final TextEditingController otpController;

class _SignInState extends State<SignIn> {
  final _auth = PhoneAuth();

  @override
  void initState() {
    phoneController = TextEditingController();
    otpController = TextEditingController();
    _auth.otpVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  
  final _formKey = GlobalKey<FormState>();

  bool isPressed = false;

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
                          } else if (value.length < 10 || value.length > 14) {
                            return 'Invalid input';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                          visible: _auth.otpVisible,
                          child: customTextField(
                              hintText: 'Enter code recieved',
                              controller: otpController)),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          log('pressed');
                          if (_formKey.currentState!.validate()) {
                          try { if (_auth.otpVisible) {
                              _auth.verifyOtp();
                              setState(() {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) => Home()));
                              });
                            } else {
                              
                              _auth.verifyFone();
                              
                              setState(() {
                                isPressed?CircularProgressIndicator():null;
                              
                              });
                            }} on FirebaseAuthException catch (e){
                              switch (e) {
                                
                              }
                            }
                          }
                        },
                        child: Text(_auth.otpVisible ? 'Verify' : 'Continue'),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

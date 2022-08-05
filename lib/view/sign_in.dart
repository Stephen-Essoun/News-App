import 'package:chedda/service/auth/phone_auth.dart';
import 'package:chedda/utilities/fuctions.dart';
import 'package:chedda/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:developer' show log;

import '../utilities/textfield.dart';

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
    phoneController.clear();
    otpController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.black,
              Colors.red,
              Colors.black,
              Colors.red,
              Colors.black,
              Colors.blue,
              Colors.black,
    
            ],
            transform: GradientRotation(0),
            stops: [
              0.1,
              0.1,
              0.1,
              0.2,
              0.3,
              0.1,0.4,2
            ],
          ),
        ),
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
                          hintText: 'Phone(starts with country code)',
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return dialogue(context,
                                  content: Text('Please enter your phone'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Okay'),
                                    ),
                                  ]).toString();
                            } else if (value.length < 10 || value.length > 14) {
                              return dialogue(context,
                                  content: Text('Invalid input'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Okay'),
                                    ),
                                  ]).toString();
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
                              _auth.verifyFone();
                              Future.delayed(
                                Duration(
                                  seconds: 10,
                                ),
                                () {
                                  return otpTextField(context);
                                },
                              );
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
      ),
    );
  }
}

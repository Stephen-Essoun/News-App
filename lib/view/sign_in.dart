import 'package:chedda/service/auth/phone_auth.dart';
import 'package:chedda/utilities/fuctions.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:developer' show log;

import '../const/constant.dart' show space;
import '../utilities/textfield.dart';

final _auth = PhoneAuth();

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

late TextEditingController phoneController;
late TextEditingController otpController;
late String country_code_picker;

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
            stops: [0.1, 0.1, 0.1, 0.2, 0.3, 0.1, 0.4, 2],
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
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),),
                          child: CountryCodePicker(
                            backgroundColor: Colors.amber,
                            dialogBackgroundColor: Colors.blue[300],
                            flagDecoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                            ),
                            initialSelection: "GH",
                            showCountryOnly: false,
                            onInit: (code) {
                              country_code_picker = code.toString();
                            }, onChanged: (code) {
                              country_code_picker = code.toString();
                            },
                          ),
                        ),
                        space,
                        customTextField(
                          hintText: 'Phone',
                          decoration: InputDecoration(
                            isDense: true,
                            errorStyle: TextStyle(height: 0, fontSize: 0),
                          ),
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
                            } else if (value.length < 9 || value.length > 14 || country_code_picker.trim().isEmpty ) {
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
                        space,
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

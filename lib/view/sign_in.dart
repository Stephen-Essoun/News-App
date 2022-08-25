import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
 import 'dart:developer' as devprint show log;

import '../const/constant.dart' show space;
import '../service/auth/phone_auth.dart';
import '../utilities/fuctions.dart';
import '../utilities/textfield.dart';
 
final _auth = PhoneAuth();

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

late TextEditingController phoneController;
late TextEditingController otpController;
// ignore: non_constant_identifier_names
late String country_code_picker;
String editedPhone = phoneController.text
    .replaceFirst(RegExp(r'^0+'), country_code_picker.toString());

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
        decoration: const BoxDecoration(
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
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CountryCodePicker(
                            backgroundColor: Colors.amber,
                            dialogBackgroundColor: Colors.blue[300],
                            flagDecoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                            ),
                            initialSelection: "GH",
                            showCountryOnly: false,
                            onInit: (code) {
                              country_code_picker = code.toString();
                            },
                            onChanged: (code) {
                              country_code_picker = code.dialCode.toString();
                              devprint.log(code.toString());
                            },
                          ),
                        ),
                        space,
                        customTextField(
                          // onFieldSubmitted: (p0) {
                          //   FilteringTextInputFormatter.deny(RegExp(r'^0+'));
                          //   FilteringTextInputFormatter.allow(RegExp('[0-9]'));
                          //   print(phoneController.text);
                          // },
                          labelText: 'Phone',
                          decoration: const InputDecoration(
                            isDense: true,
                            errorStyle: TextStyle(height: 0, fontSize: 0),
                          ),
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return dialogue(context,
                                  content:
                                      const Text('Please enter your phone'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Okay'),
                                    ),
                                  ]).toString();
                            } else if (value.length < 9 ||
                                value.length > 14 ||
                                country_code_picker.trim().isEmpty) {
                              return dialogue(context,
                                  content: const Text('Invalid input'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Okay'),
                                    ),
                                  ]).toString();
                            }
                            return null;
                          },
                        ),
                        space,
                        ElevatedButton(
                          onPressed: () {
                            devprint.log(editedPhone);
                            if (_formKey.currentState!.validate()) {
                              _auth.verifyFone();
                              Future.delayed(
                                const Duration(
                                  seconds: 10,
                                ),
                                () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (_) => const OtpCodeReciver()));
                                },
                              );
                            }
                          },
                          child: const Text(
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

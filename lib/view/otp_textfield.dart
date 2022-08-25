import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../service/auth/phone_auth.dart';
import '../utilities/fuctions.dart';
import 'home.dart';

class OtpCodeReciver extends StatefulWidget {
  const OtpCodeReciver({Key? key}) : super(key: key);

  @override
  State<OtpCodeReciver> createState() => _OtpCodeReciverState();
}

class _OtpCodeReciverState extends State<OtpCodeReciver> {
  final PhoneAuth _auth = PhoneAuth();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OtpTextField(
                numberOfFields: 6,
                borderColor: const Color(0xFF512DA8),
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  if (code.trim().isEmpty) {
                    dialogue(context,
                        content:const Text('Fields can not be empty'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child:const Text('Okay'),
                          ),
                        ]);
                  } else if (code != code) {
                    dialogue(context,
                        content: const Text('Code mismatch'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Okay'),
                          ),
                        ]);
                  }
                }
                //runs when every textfield is filled
                // end onSubmit
                ),
            TextButton(
              onPressed: () {
                _auth.verifyFone();
              },
              child:const Text('Resend code'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _auth.verifyOtp();
                  Future.delayed(
                   const  Duration(seconds: 2),
                    () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) =>const Home()),
                        (route) => false,
                      );
                    },
                  );
                }
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:chedda/service/auth/phone_auth.dart';
import 'package:chedda/utilities/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../view/home.dart';
import '../view/sign_in.dart';

PhoneAuth _auth = PhoneAuth();
final context = BuildContext;
  final _formKey = GlobalKey<FormState>();


Future dialogue(
  BuildContext context, {
  TextFormField? title,
  List<Widget>? actions,
  Widget? content,
}) {
  return showDialog(
    context: (context),
    builder: (_) => AlertDialog(
      title: title,
      content: content,
      actions: actions,
    ),
  );
}

otpTextField(BuildContext context) {
  return dialogue(
    context,
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
      TextButton(
        onPressed: () {
          _auth.verifyOtp();
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) => Home()), (route) => false);
           
           
          });
        },
        child: Text('Continue'),
      ),
    ],

    title: customTextField(
      controller: otpController,
      hintText: 'Enter code recieved',
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value != otpController.text) {
          return dialogue(context,content: Text('sorry, code do not match'), actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay'),
            ),
          ]).toString();
        }
        return '';
      },
    ),
  );
}

validator(
  BuildContext context,
  value,
) {
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
        ]);
  } else if (value.length < 10 || value.length > 14) {
    return dialogue(context, content: Text('Invalid input'), actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Okay'),
      ),
    ]);
  }
  return null;
}

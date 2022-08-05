import 'package:chedda/service/auth/phone_auth.dart';
import 'package:chedda/utilities/textfield.dart';
import 'package:flutter/material.dart';

import '../view/home.dart';
import '../view/sign_in.dart';

PhoneAuth _auth = PhoneAuth();

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
      Visibility(
        visible: true,
        child: TextButton(
          onPressed: () {
            _auth.verifyFone();
          },
          child: Text('Resend code'),
        ),
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
          Future.delayed(Duration(seconds: 1), () {
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
    ),
  );
}

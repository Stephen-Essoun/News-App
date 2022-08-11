import 'package:chedda/service/auth/phone_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../view/home.dart';
PhoneAuth _auth = PhoneAuth();
final context = BuildContext;
final _formKey = GlobalKey<FormState>();

Future dialogue(
  BuildContext context, {
  Widget? title,
  List<Widget>? actions,
  Widget? content,
}) {
  return showDialog(
    context: (context),
    barrierColor: Color.fromARGB(205, 0, 0, 0),
    builder: (_) => ListView(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: [
        AlertDialog(
          title: title,
          content: content,
          actions: actions,
        ),
      ],
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
          Future.delayed(
            Duration(seconds: 2),
            () {
          
               Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => Home()),
                (route) => false,
              );
            
             
            },
          );
         
        },
        child: Text('Continue'),
      ),
    ],
    title: Form(key: _formKey,
      child: Center(
        child: OtpTextField(
            numberOfFields: 6,
            borderColor: Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              if (code.trim().isEmpty) {
                dialogue(context, content: Text('Fields can not be empty'),actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Okay'),
          ),
        ]);
              } else if (code != code) {
                dialogue(context, content: Text('Code mismatch'),actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Okay'),
          ),
        ]);
              }
            }
            //runs when every textfield is filled
            // end onSubmit
            ),
      ),
    ),
    // customTextField(
    //   controller: otpController,
    //   hintText: 'Enter code recieved',
    //   keyboardType: TextInputType.number,
    //   validator: (value) {
    //     if (value != otpController.text) {
    //       return dialogue(context,content: Text('sorry, code do not match'), actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: Text('Okay'),
    //         ),
    //       ]).toString();
    //     }
    //     return '';
    //   },
    // ),
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

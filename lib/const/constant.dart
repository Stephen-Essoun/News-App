import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const space = SizedBox(height: 10,);
const signInRoute = '/signIn/';
const registerRoute = '/register/';

  final spinkit = SpinKitCircle(
    itemBuilder: (BuildContext context, int index) {
      return const DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      );
    },
  );
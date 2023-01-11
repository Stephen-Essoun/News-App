import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

int? height;
const space = SizedBox(
  height: 10,
);
const space2 = SizedBox(
  height: 80,
);

bool isLoading = false;

final spinkit = SpinKitCircle(
  itemBuilder: (BuildContext context, int index) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
    );
  },
);

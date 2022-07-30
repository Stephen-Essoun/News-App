import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Indicator {
  spinkits() {
    return Center(
      child: SpinKitCircle(
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          );
        },
      ),
    );
  }
}

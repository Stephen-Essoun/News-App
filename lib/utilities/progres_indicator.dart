import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Indicator {
  spinkits() {
    return Center(
      child: SpinKitCircle(
        itemBuilder: (BuildContext context, int index) {
          return const DecoratedBox(
            decoration:   BoxDecoration(
              color: Colors.blue,
            ),
          );
        },
      ),
    );
  }
}

startLoading(String message) {
  return EasyLoading.show(
    status: message,
    maskType: EasyLoadingMaskType.black,
  );
}

stopLoading() {
  return EasyLoading.dismiss();
}

import 'package:flutter/material.dart';

Future dialogue(
  BuildContext context, {
  Widget? title,
  List<Widget>? actions,
  Widget? content,
}) {
  return showDialog(
    context: (context),
    barrierColor: const Color.fromARGB(205, 0, 0, 0),
    builder: (_) => ListView(
      physics: const NeverScrollableScrollPhysics(),
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




import 'package:flutter/material.dart';

TextFormField customTextField({
  TextEditingController? controller,
  String? initialValue,
  FocusNode? focusNode,
  InputDecoration? decoration = const InputDecoration(),
  TextInputType? keyboardType,
  TextInputAction? textInputAction,
  TextStyle? style,
  String? hintText,
  String obscuringCharacter = '•',
  bool obscureText = false,
  bool autocorrect = true,
  void Function(String)? onChanged,
  void Function()? onTap,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    validator: validator,
    cursorHeight: 25,
    obscureText: obscureText,
    decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        fillColor: Color.fromARGB(255, 178, 91, 91),
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
  );
}

import 'package:flutter/material.dart';

TextFormField customTextField({
  TextEditingController? controller,
  String? initialValue,
  FocusNode? focusNode,
  InputDecoration? decoration = const InputDecoration(),
  TextInputType? keyboardType,
  TextInputAction? textInputAction,
  TextStyle? style,
  String? labelText,
  String obscuringCharacter = '•',
  bool obscureText = false,
  bool autocorrect = true,
  void Function(String)? onChanged,
  void Function()? onTap,
  void Function(String)? onFieldSubmitted,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    onFieldSubmitted: (value) {},
    controller: controller,
    keyboardType: keyboardType,
    validator: validator,
    cursorHeight: 25,
    obscureText: obscureText,
    decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        fillColor: const Color.fromARGB(255, 253, 253, 253),
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
  );
}
 
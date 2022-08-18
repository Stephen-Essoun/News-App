import 'dart:developer' as console show log;

void main() {
  int cc = 233;
  String phone = '00073045';
  String editedPhone = phone.replaceFirst(RegExp(r'^0+'), cc.toString());
   print(phone);
   print(editedPhone);
}

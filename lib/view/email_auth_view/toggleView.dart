 // ignore_for_file: file_names

 import 'package:all_news/const/routes.dart';
import 'package:flutter/material.dart'; 

class ToggleView extends StatefulWidget {
  const ToggleView({Key? key}) : super(key: key);
  

  @override
  State<ToggleView> createState() => _ToggleViewState();
  
}

late bool toggleIt;


class _ToggleViewState extends State<ToggleView> {
   handleToggle() {
    toggleIt == true ? signInRoute : registerRoute;
    setState(() {
      toggleIt = !toggleIt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return handleToggle();
  }
}

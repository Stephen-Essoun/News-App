import 'package:all_news/const/constant.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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

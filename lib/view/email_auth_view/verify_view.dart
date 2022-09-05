import 'package:all_news/const/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/auth/email_auth.dart';

class EmailVerifyView extends StatelessWidget {
  const EmailVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Be a verified user',
            style: Theme.of(context).textTheme.headline5,
          ),
          ElevatedButton(
              onPressed: () {
                context.read<EmailAuth>().verifyUser();
                context.read<EmailAuth>().currentuser!.reload();
              },
              child: const Text('Verify')),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, signInRoute),
            icon: const Icon(Icons.cancel),
            iconSize: 40,
          )
        ]),
      ),
    );
  }
}

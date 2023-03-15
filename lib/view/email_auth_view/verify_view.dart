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
                context.read<EmailAuth>().verifyUser(context);
                context.read<EmailAuth>().currentuser!.reload().then((value) {
                  showDialog(
                      context: context,
                      builder: (ctx) => const AspectRatio(
                            aspectRatio: 16 / 19,
                            child: Dialog(
                              child: (Text(
                                  'Check your email to verify then login back. Thanks!')),
                            ),
                          ));
                  Future.delayed(
                    const Duration(seconds: 3),
                    () => Navigator.pushNamed(context, signInRoute),
                  );
                });
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

import 'package:all_news/controller/share_link.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Detector extends StatefulWidget {
  const Detector({super.key, required this.detailed});
  final dynamic detailed;

  @override
  State<Detector> createState() => _DetectorState();
}

class _DetectorState extends State<Detector> {
  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse(widget.detailed.url);

    void urlLauncher() async {
      if (!await launchUrl(url)) throw 'Could not launch $url';
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new)),
        actions: [
          IconButton(
              onPressed: () => shareLink(widget.detailed.url),
              icon: const Icon(Icons.share)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: ListView(
          children: [
            Text(widget.detailed.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(
              height: 5,
            ),
            Image.network(widget.detailed.urlToImage),
            const SizedBox(
              height: 5,
            ),
            Text(widget.detailed.content, style: const TextStyle(fontSize: 18)),
            const SizedBox(
              height: 5,
            ),
            Text(widget.detailed.description,
                style: const TextStyle(fontSize: 18)),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                    text: 'Find more detailed info',
                    style: const TextStyle(color: Colors.black),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        urlLauncher();
                      },
                    children: [
                      TextSpan(
                        text: ' here',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            urlLauncher();
                          },
                      )
                    ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Text("Author: ${widget.detailed.author}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Detector extends StatefulWidget {
  Detector({Key? key, required this.detailed}) : super(key: key);
  final dynamic detailed;

  @override
  State<Detector> createState() => _DetectorState();
}

class _DetectorState extends State<Detector> {
  @override
  Widget build(BuildContext context) {
   final Uri _url = Uri.parse(widget.detailed.url);
   
void _launchUrl() async {
  if (!await launchUrl(_url)) throw 'Could not launch $_url';
}

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10,right: 10,left: 10),
        child: ListView(
          children: [
            Text(widget.detailed.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(
              height: 5,
            ),
            Image.network(widget.detailed.urlToImage),
            SizedBox(
              height: 5,
            ),
            Text(widget.detailed.content, style: TextStyle(fontSize: 18)),
            SizedBox(
              height: 5,
            ),
            Text(widget.detailed.description, style: TextStyle(fontSize: 18)),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Text('Find more detailed info here'),
                InkWell(child: Text('Click here', style: TextStyle(color: Colors.blue)),onTap: (){
                    setState(() {_launchUrl();
                });
  //                showDialog(
  //             context: context,
  //             builder: (BuildContext context) =>  AlertDialog(
  //   content: Text("Not available now!\nThanks!"),
  //   actions: <Widget>[
  //     ElevatedButton(
  //       onPressed: () {
  //         Navigator.of(context).pop();
  //       },
  //       child: const Text('OK'),
  //     ),
  //   ],
  // )
  //           );
                },),
              ],
            ),SizedBox(
              height: 10,
            ),
            Center(
                child: Text("Author:${widget.detailed.author}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)))
          ],
        ),
      ),
    );
  }
}
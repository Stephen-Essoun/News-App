import 'package:chedda/view/news_in_detail.dart';
import 'package:chedda/controller/network.dart';
import 'package:chedda/view/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/api.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearchVisible = false;
  Future<NewsApi>? newsData;
  Network network = Network();
  @override
  void initState() {
    newsData = network.getNews();
    super.initState();
  }

  final Uri url =
      Uri.parse('https://www.youtube.com/channel/UC9QYHCZqkLK20QdBAe31EDQ');
  void _launchUrl() async {
    if (!await launchUrl(url)) {
      throw 'something happened\nTry again';
    }
  }

  final spinkit = SpinKitCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Center(
                  child: IconButton(
                icon: Icon(
                  Icons.support,
                  color: Color.fromARGB(255, 178, 91, 91),
                ),
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text(
                                "Would you like to support the developer's youtube channel?"),
                            actions: [
                              ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.thumb_down),
                                  label: Text('No')),
                              ElevatedButton.icon(
                                  onPressed: () {
                                    _launchUrl();
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  },
                                  icon: Icon(Icons.thumb_up_off_alt_rounded),
                                  label: Text('Yes'))
                            ],
                          ));
                },
                splashRadius: 01,
              )),
            ),
          ),
          centerTitle: true,
          title:
              // isSearchVisible
              //     ? TextField(
              //         decoration: InputDecoration(
              //         filled: true,
              //         fillColor: Colors.white,
              //         border: InputBorder.none,
              //         hintText: "search news",
              //       ))
              // :
              Text(
            "Tech News",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: 'Oxygen',
                fontWeight: FontWeight.bold),
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                Future.delayed(
                    Duration(seconds: 1), () => Center(child: spinkit));
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => SignIn()),
                    (route) => false);
              },
              icon: Icon(Icons.logout),
              label: Text('LogOut'),
            )
          ],
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: IconButton(
          //         onPressed: () {
          //           setState(() {
          //             isSearchVisible = !isSearchVisible;
          //           });
          //         },
          //         icon: isSearchVisible
          //             ? Icon(Icons.cancel)
          //             : Icon(Icons.search)),
          //   )
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 5, right: 10, left: 10),
          child: FutureBuilder<NewsApi>(
              future: newsData,
              builder: (context, AsyncSnapshot<NewsApi> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: spinkit);
                }
                else if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                      child: Text("please check your internet connection"));
                }

                return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.all(5),
                                  height: 100,
                                  child: Center(
                                      child: Text(
                                    snapshot.data!.articles![index].title!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ))),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(snapshot
                                      .data!.articles![index].urlToImage!))),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detector(
                                    detailed:
                                        snapshot.data!.articles![index]))),
                      );
                    },
                    staggeredTileBuilder: (index) {
                      return new StaggeredTile.count(
                          1, index.isEven ? 1.2 : 1.4);
                    });
              }),
        ));
  }
}


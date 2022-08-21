import 'package:all_news/const/constant.dart';
import 'package:all_news/service/auth/email_auth.dart';
import 'package:all_news/view/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/network.dart';
import '../model/api.dart';
import 'news_in_detail.dart';

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
    newsData = network.getNews() as Future<NewsApi>?;
    super.initState();
  }

  final Uri url =
      Uri.parse('https://www.youtube.com/channel/UC9QYHCZqkLK20QdBAe31EDQ');
  void _launchUrl() async {
    if (!await launchUrl(url)) {
      throw 'something happened\nTry again';
    }
  }

  final EmailAuth _auth = EmailAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Center(
                  child: IconButton(
                icon: const Icon(
                  Icons.support,
                  color: Color.fromARGB(255, 178, 91, 91),
                ),
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => AlertDialog(
                            title: const Text(
                                "Would you like to support the developer's youtube channel?"),
                            actions: [
                              ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.thumb_down),
                                  label: const Text('No')),
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
              const Text(
            "Tech News",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: 'Oxygen',
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Future.delayed(
                    const Duration(seconds: 1), () => Center(child: spinkit));
                _auth.handleSignOut();
              },
              icon: const Icon(Icons.logout),
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
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 10,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(snapshot
                                        .data!.articles![index].urlToImage!))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: const EdgeInsets.all(5),
                                    height: 100,
                                    child: Center(
                                        child: Text(
                                      snapshot.data!.articles![index].title!,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ))),
                              ],
                            ),
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
                            1, index.isEven ? 1.6 : 1.4);
                      });
                }
                return Center(
                  child: Text("please check your internet connection"),
                );
              }),
        ));
  }
}

import 'package:all_news/const/constant.dart';
import 'package:all_news/service/auth/email_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
    _auth.context = context;

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

  final EmailAuth _auth = EmailAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(50, 141, 0, 0),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffffffff),
              ),
              child: Center(
                  child: IconButton(
                icon: const Icon(
                  Icons.support,
                  color: Color(0xff8d0000),
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
                                  icon: const Icon(
                                      Icons.thumb_up_off_alt_rounded),
                                  label: const Text('Yes'))
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
                showDialog(
                    context: context, builder: (_) => Center(child: spinkit));

                Future.delayed(
                  const Duration(seconds: 2),
                  () {
                    _auth.handleSignOut();
                  },
                );
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 10, left: 10),
            child: FutureBuilder<NewsApi>(
                future: newsData,
                builder: (context, AsyncSnapshot<NewsApi> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: spinkit);
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    ///////////////
                    var dataAvailable = snapshot.data!.articles;
                    return CarouselSlider.builder(
                      itemCount: dataAvailable!.length,
                      itemBuilder: (context, index, realIndex) =>
                          GestureDetector(
                        child: Card(
                          elevation: 10,
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xff8d0000),
                                borderRadius: BorderRadius.circular(2),
                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: NetworkImage(
                                        dataAvailable[index].urlToImage!))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.5),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(15))),
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
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detector(
                                    detailed:
                                        snapshot.data!.articles![index]))),
                      ),
                      options: CarouselOptions(
                        height: 400,
                        // aspectRatio: 1,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        // onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                    // return StaggeredGridView.countBuilder(
                    //     crossAxisCount: 2,
                    //     crossAxisSpacing: 8,
                    //     mainAxisSpacing: 10,
                    //     itemCount: 10,
                    //     itemBuilder: (context, index) {
                    //       return
                    //     },
                    //     staggeredTileBuilder: (index) {
                    //       return StaggeredTile.count(1, index.isEven ? 1.6 : 1.4);
                    //     });
                  }
                  return const Center(
                    child: Text("please check your internet connection"),
                  );
                }),
          ),
        ));
  }
}

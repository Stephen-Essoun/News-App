import 'package:all_news/const/constant.dart';
import 'package:all_news/service/auth/email_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/network.dart';
import '../controller/share_link.dart';
import '../model/api.dart';
import 'news_in_detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearchVisible = false;

  @override
  void initState() {
    _auth.context = context;
    getNews();
    super.initState();
  }

  final Uri youTubeUrl =
      Uri.parse('https://www.youtube.com/channel/UC9QYHCZqkLK20QdBAe31EDQ');
  void _launchUrl() async {
    if (!await launchUrl(youTubeUrl)) {
      throw 'something happened\nTry again';
    }
  }

//instance of EmailAuth class
  final EmailAuth _auth = EmailAuth();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getNews,
      backgroundColor: const Color(0xffffffff),
      color: const Color(0xff8d0000),
      child: Scaffold(
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
              onPressed: () => showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text("Logging out?"),
                        actions: [
                          ElevatedButton.icon(
                              onPressed: () => _auth.handleSignOut(),
                              icon: const Icon(Icons.thumb_up_off_alt_rounded),
                              label: const Text('Yes'))
                        ],
                      )),
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 10, left: 10),
            child: FutureBuilder<NewsApi>(
                future: getNews(),
                builder: (context, AsyncSnapshot<NewsApi> snapshot) {
                  if (snapshot.hasData) {
                    var dataAvailable = snapshot.data!.articles;
                    return StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 10,
                      itemCount: 10,
                      staggeredTileBuilder: (index) {
                        return StaggeredTile.count(1, index.isEven ? 1.6 : 1.5);
                      },
                      itemBuilder: (context, index) {
                        return NewsCard(
                          dataAvailable: dataAvailable,
                          index: index,
                          snapshot: snapshot,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child:
                          Text('Please check your network and restart the app'),
                    );
                  }
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      spinkit,
                      const Text(
                        'fetching news',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ));
                }),
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatefulWidget {
  const NewsCard(
      {Key? key,
      required this.dataAvailable,
      required this.index,
      required this.snapshot})
      : super(key: key);

  final List<Article>? dataAvailable;
  final int index;
  final AsyncSnapshot snapshot;

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Detector(
                  detailed: widget.snapshot.data!.articles![widget.index]))),
      onLongPress: () {
        setState(() {
          isSelected = true;
        });
      },
      child: Card(
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff8d0000),
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image:
                  NetworkImage(widget.dataAvailable![widget.index].urlToImage!),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Visibility(
                visible: isSelected,
                child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          shareLink(widget.dataAvailable![widget.index].url);
                        },
                        icon: const Icon(
                          Icons.share,
                          color: Color(0xffffffff),
                        ))),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.5),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15))),
                  padding: const EdgeInsets.all(5),
                  height: 100,
                  child: Center(
                      child: Text(
                    widget.snapshot.data!.articles![widget.index].title!,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ))),
            ],
          ),
        ),
      ),
    );
  }
}

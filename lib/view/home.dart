import 'package:all_news/const/constant.dart';
import 'package:all_news/service/auth/email_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/network.dart';
import '../controller/network_connection.dart';
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
    //////////////////////////////////////
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _source = source;
      print('source $_source');
      // 1.
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          string =
              _source.values.toList()[0] ? 'Mobile: Online' : 'Mobile: Offline';
          break;
        case ConnectivityResult.wifi:
          string =
              _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
          break;
        case ConnectivityResult.none:
        default:
          string = 'Offline';
      }
      // 2.
      setState(() {});
      // 3.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            string,
            style: const TextStyle(fontSize: 30),
          ),
        ),
      );
    });
    //////////////////////////////////////
    super.initState();
  }

  final Uri url =
      Uri.parse('https://www.youtube.com/channel/UC9QYHCZqkLK20QdBAe31EDQ');
  void _launchUrl() async {
    if (!await launchUrl(url)) {
      throw 'something happened\nTry again';
    }
  }

  ////////////////////////////////////////////
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  @override
  void dispose() {
    _networkConnectivity.disposeStream();
    super.dispose();
  }

  ////////////////////////////////////////////

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
                  context: context,
                  builder: (context) => SizedBox(
                        height: 200,
                        child: AlertDialog(
                          alignment: Alignment.center,
                          content: Text(
                            'Logging out!',
                            style: TextStyle(fontSize: 18),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () => _auth.handleSignOut(),
                                child: const Text('Ok'))
                          ],
                        ),
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
                    ///////////////
                    var dataAvailable = snapshot.data!.articles;

                    return StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 10,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Card(
                              elevation: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xff8d0000),
                                  borderRadius: BorderRadius.circular(2),
                                  image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: NetworkImage(
                                        dataAvailable![index].urlToImage!),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                          snapshot
                                              .data!.articles![index].title!,
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
                          );
                        },
                        staggeredTileBuilder: (index) {
                          return StaggeredTile.count(
                              1, index.isEven ? 1.6 : 1.4);
                        });
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
